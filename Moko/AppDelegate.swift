	//
//  AppDelegate.swift
//  Moko
//
//  Created by William Meek on 6/20/26.
//

import UIKit
import CoreText
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerBundledFonts()
        // Wire the Firebase backend in behind the app's seam (Backend.auth /
        // Backend.store); everything else talks to the protocols, not Firebase.
        FirebaseApp.configure()
        Backend.install(auth: FirebaseBackend.shared, store: FirebaseBackend.shared)
        return true
    }

    /// Register the bundled DIN Round Pro faces so SwiftUI can use them by name
    /// (matches the web app's typeface instead of the SF Rounded stand-in).
    private func registerBundledFonts() {
        let urls = Bundle.main.urls(forResourcesWithExtension: "otf", subdirectory: nil) ?? []
        let nested = Bundle.main.urls(forResourcesWithExtension: "otf", subdirectory: "fonts") ?? []
        for url in Set(urls + nested) {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

