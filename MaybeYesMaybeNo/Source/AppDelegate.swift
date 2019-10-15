//
//  AppDelegate.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        migrationRealmDataBase()
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbarController = RootTabBarController()
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .black
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
    }

    private func migrationRealmDataBase() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
}
