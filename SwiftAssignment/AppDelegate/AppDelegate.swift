//
//  AppDelegate.swift
//  SwiftAssignment
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: DataListViewController())
        window?.makeKeyAndVisible()
    }
}
