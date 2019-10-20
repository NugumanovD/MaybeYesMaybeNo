//
//  RootTabBarController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/16/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//
import UIKit

extension UITabBarController {
    static func makeRootController() -> UITabBarController {
        let controller = UITabBarController()
        let model = MainModel(networker: NetworkManager(), localStorage: DataBaseManager(), keychain: KeychainManager())
        let viewModel = MainViewModel(model: model)
        let mainViewController = MainViewController(mainViewModel: viewModel)
        let settingsModel = SettingsModel(localStorage: DataBaseManager())
        let settingsVewModel = SettingsViewModel(model: settingsModel)
        let secondViewController = SettingsViewController(viewModel: settingsVewModel)
        controller.viewControllers = [
            UINavigationController(rootViewController: mainViewController),
            UINavigationController(rootViewController: secondViewController)
        ]
        return controller
    }
}
