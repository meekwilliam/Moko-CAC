import Foundation

// MARK: - Backend seam
// The app talks ONLY to these protocols — never to Firebase (or any vendor)
// directly. The concrete backend lives in one file that conforms to them, and
// `Backend.auth` / `Backend.store` are the single swap points. Switching
// providers later (Supabase, a custom API, …) means writing one new conforming
// type and flipping those two assignments — nothing else in the app changes.
//
// Milestone 1 = auth + progress sync:
//   • AuthService  — real Apple / Google sign-in, one stable user id.
//   • RemoteStore  — push/pull the ProgressStore snapshot (a portable JSON
//                    blob, one record per user) so progress follows the user.

struct BackendUser: Equatable {
    let id: String            // stable provider-agnostic uid
    var email: String?
    var displayName: String?
}

enum BackendError: Error {
    case notConfigured        // no backend wired yet (local-only build)
    case notSignedIn
    case cancelled
}

protocol AuthService {
    var currentUser: BackendUser? { get }
    /// Silent re-auth on launch (returns the cached user if the session is still valid).
    func restore() async -> BackendUser?
    func signInWithApple() async throws -> BackendUser
    func signInWithGoogle() async throws -> BackendUser
    func signOut() throws
}

protocol RemoteStore {
    /// The whole ProgressStore snapshot as JSON, keyed by user id. `nil` = no
    /// cloud record yet (fresh account → keep whatever is local).
    func loadSnapshot(userID: String) async throws -> Data?
    func saveSnapshot(userID: String, json: Data) async throws
    // Leaderboards / analytics land here in later milestones.
}

// MARK: - Default: local-only (no cloud)
// Lets the app build and run exactly as today. Auth reports "not configured"
// so callers gracefully fall back to the local-first flow until Firebase is
// wired in and assigned to `Backend.auth` / `Backend.store` at launch.
final class LocalOnlyBackend: AuthService, RemoteStore {
    static let shared = LocalOnlyBackend()
    private(set) var currentUser: BackendUser? = nil

    func restore() async -> BackendUser? { nil }
    func signInWithApple() async throws -> BackendUser { throw BackendError.notConfigured }
    func signInWithGoogle() async throws -> BackendUser { throw BackendError.notConfigured }
    func signOut() throws {}

    func loadSnapshot(userID: String) async throws -> Data? { nil }
    func saveSnapshot(userID: String, json: Data) async throws {}

    /// True once a real backend has been installed (see Backend.install).
    static var isConfigured = false
}

// MARK: - Global provider (the swap points)
enum Backend {
    static var auth: AuthService = LocalOnlyBackend.shared
    static var store: RemoteStore = LocalOnlyBackend.shared

    /// Called once at launch after the concrete backend is created, e.g.
    ///   Backend.install(auth: FirebaseBackend.shared, store: FirebaseBackend.shared)
    static func install(auth: AuthService, store: RemoteStore) {
        self.auth = auth
        self.store = store
        LocalOnlyBackend.isConfigured = true
    }

    static var isConfigured: Bool { LocalOnlyBackend.isConfigured }
}
