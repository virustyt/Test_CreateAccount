//
//  AppDelegate.swift
//  Test_CreateAccount
//
//  Created by Vladimir Oleinikov on 22.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let createAccountVC = CreateAccountViewController()

        let navigationVC = UINavigationController(rootViewController: createAccountVC)
        navigationVC.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22)]

        window = UIWindow()

        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()

        return true
    }
}

