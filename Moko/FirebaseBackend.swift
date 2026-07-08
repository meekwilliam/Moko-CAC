import Foundation
import UIKit
import AuthenticationServices
import CryptoKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

// MARK: - Firebase implementation of the backend seam
// The ONLY file that imports Firebase / Google. Conforms to AuthService +
// RemoteStore; installed at launch via Backend.install(...). Swapping providers
// later = replace this one file. Progress is stored as a portable JSON blob at
// users/{uid}.snapshot so it isn't locked to Firestore's shape.

final class FirebaseBackend: NSObject, AuthService, RemoteStore {
    static let shared = FirebaseBackend()
    private let db = Firestore.firestore()

    // MARK: AuthService

    var currentUser: BackendUser? {
        Auth.auth().currentUser.map(Self.user(from:))
    }

    /// Firebase persists the session in the keychain, so a returning user is
    /// already authenticated on launch — just surface the cached user.
    func restore() async -> BackendUser? { currentUser }

    func signOut() throws {
        GIDSignIn.sharedInstance.signOut()
        try Auth.auth().signOut()
    }

    private static func user(from u: FirebaseAuth.User) -> BackendUser {
        BackendUser(id: u.uid, email: u.email, displayName: u.displayName)
    }

    // MARK: Google sign-in

    @MainActor
    func signInWithGoogle() async throws -> BackendUser {
        guard let clientID = FirebaseApp.app()?.options.clientID else { throw BackendError.notConfigured }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        guard let presenter = Self.topViewController() else { throw BackendError.notConfigured }

        let result: GIDSignInResult
        do {
            result = try await GIDSignIn.sharedInstance.signIn(withPresenting: presenter)
        } catch let e as NSError where e.code == GIDSignInError.canceled.rawValue {
            throw BackendError.cancelled
        }
        guard let idToken = result.user.idToken?.tokenString else { throw BackendError.notSignedIn }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: result.user.accessToken.tokenString)
        let authResult = try await Auth.auth().signIn(with: credential)
        return Self.user(from: authResult.user)
    }

    // MARK: Apple sign-in (native ASAuthorization → Firebase credential)

    private var appleContinuation: CheckedContinuation<BackendUser, Error>?
    private var currentNonce: String?

    @MainActor
    func signInWithApple() async throws -> BackendUser {
        let nonce = Self.randomNonceString()
        currentNonce = nonce
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = Self.sha256(nonce)

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        return try await withCheckedThrowingContinuation { cont in
            self.appleContinuation = cont
            controller.performRequests()
        }
    }

    // MARK: RemoteStore — one JSON blob per user

    func loadSnapshot(userID: String) async throws -> Data? {
        let doc = try await db.collection("users").document(userID).getDocument()
        guard let json = doc.get("snapshot") as? String else { return nil }
        return json.data(using: .utf8)
    }

    func saveSnapshot(userID: String, json: Data) async throws {
        let str = String(data: json, encoding: .utf8) ?? ""
        try await db.collection("users").document(userID).setData([
            "snapshot": str,
            "updatedAt": FieldValue.serverTimestamp(),
        ], merge: true)
    }

    // MARK: Helpers

    static func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let root = base ?? UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
        if let nav = root as? UINavigationController { return topViewController(nav.visibleViewController) }
        if let tab = root as? UITabBarController { return topViewController(tab.selectedViewController) }
        if let presented = root?.presentedViewController { return topViewController(presented) }
        return root
    }

    private static func randomNonceString(length: Int = 32) -> String {
        let charset = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remaining = length
        while remaining > 0 {
            var random: UInt8 = 0
            _ = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if random < charset.count { result.append(charset[Int(random)]); remaining -= 1 }
        }
        return result
    }

    private static func sha256(_ input: String) -> String {
        SHA256.hash(data: Data(input.utf8)).map { String(format: "%02x", $0) }.joined()
    }
}

// MARK: - Apple auth delegate glue

extension FirebaseBackend: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first ?? ASPresentationAnchor()
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleID = authorization.credential as? ASAuthorizationAppleIDCredential,
              let nonce = currentNonce,
              let tokenData = appleID.identityToken,
              let idToken = String(data: tokenData, encoding: .utf8) else {
            finishApple(.failure(BackendError.notSignedIn)); return
        }
        let credential = OAuthProvider.appleCredential(withIDToken: idToken, rawNonce: nonce,
                                                       fullName: appleID.fullName)
        Task {
            do {
                let result = try await Auth.auth().signIn(with: credential)
                finishApple(.success(Self.user(from: result.user)))
            } catch {
                finishApple(.failure(error))
            }
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let asError = error as? ASAuthorizationError
        finishApple(.failure(asError?.code == .canceled ? BackendError.cancelled : error))
    }

    private func finishApple(_ result: Result<BackendUser, Error>) {
        appleContinuation?.resume(with: result)
        appleContinuation = nil
        currentNonce = nil
    }
}
