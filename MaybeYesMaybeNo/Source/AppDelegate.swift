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
    var navigationController: UINavigationController?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        if window != nil {
            let model = MainModel(networker: NetworkManager(), localStorage: DataBaseManager())
            let viewModel = MainViewModel(model: model)
            let mainViewController = MainViewController()
            mainViewController.attach(viewModel: viewModel)
            navigationController = UINavigationController(rootViewController: mainViewController)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        return true
    }
}
