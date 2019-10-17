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
        let dataBase = DataBaseManager()
        dataBase.migrationRealmDataBase()
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbarController = RootTabBarController()
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
        return true
    }
}
