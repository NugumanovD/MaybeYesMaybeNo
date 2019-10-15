//
//  RootTabBarController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/16/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//
import UIKit

class RootTabBarController: UITabBarController {

    private var viewControllerList = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
    }

    private func configureTabBarItems() {
        let model = MainModel(networker: NetworkManager(), localStorage: DataBaseManager(), keychain: KeychainManager())
        let viewModel = MainViewModel(model: model)
        let mainViewController = MainViewController()
        mainViewController.attach(viewModel: viewModel)
        let secondViewController = SettingsViewController()
        let settingsModel = SettingsModel(localStorage: DataBaseManager())
        let settingsVewModel = SettingsViewModel(model: settingsModel)
        secondViewController.attach(viewModel: settingsVewModel)
        setupTabBarElement(with: mainViewController, title: L10n.TabbarItem.Title.magic, image: Asset.ball.name)
        setupTabBarElement(with: secondViewController, title: L10n.TabbarItem.Title.history, image: Asset.list.name)
    }

    private func setupTabBarElement(with viewController: UIViewController, title: String, image: String) {
        let controller = UINavigationController(rootViewController: viewController)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(named: image)
        controller.navigationController?.viewControllers = viewControllerList
        navigationController?.navigationBar.barTintColor = .clear
        viewControllerList.append(controller)
        viewControllers = viewControllerList
    }
}
