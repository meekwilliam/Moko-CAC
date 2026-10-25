	//
//  AppDelegate.swift
//  Moko
//
//  Created by William Meek on 6/20/26.
//

import UIKit
import CoreText

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerBundledFonts()
        Haptics.prepare()
        return true
    }

    private func registerBundledFonts() {
        var urls: [URL] = []
        for ext in ["otf", "ttf"] {
            urls += Bundle.main.urls(forResourcesWithExtension: ext, subdirectory: nil) ?? []
            urls += Bundle.main.urls(forResourcesWithExtension: ext, subdirectory: "fonts") ?? []
        }
        for url in Set(urls) {
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
