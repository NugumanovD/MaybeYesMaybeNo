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
        if let navigationController = window?.rootViewController as? UINavigationController,
            let mainViewController = navigationController.topViewController as? MainViewController {
            let model = MainModel(networker: NetworkManager(), localStorage: DataBaseManager())
            let viewModel = MainViewModel(model: model)
            mainViewController.attach(viewModel: viewModel)
        }
        return true
    }
}
