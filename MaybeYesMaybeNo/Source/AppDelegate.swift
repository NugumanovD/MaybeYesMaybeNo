//
//  AppDelegate.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let model = MainModel(networker: NetworkManager(), localStorage: DataBaseManager())
        let viewModel = MainViewModel(model: model)
        let mainViewController = MainViewController()
        mainViewController.attach(viewModel: viewModel)
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
        return true
    }
}
