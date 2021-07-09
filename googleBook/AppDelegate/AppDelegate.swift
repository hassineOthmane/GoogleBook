//
//  AppDelegate.swift
//  googleBook
//
//  Created by hassine othmane on 7/9/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        let router = SearchBooksRouter.init()
        let vc = router.createModule()
        window.rootViewController = UINavigationController.init(rootViewController: vc)
        window.makeKeyAndVisible()
        self.window = window
        return true
    }


}

