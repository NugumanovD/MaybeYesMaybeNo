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
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        configureTabBarItems()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTabBarItems() {
        let model = MainModel(networker: NetworkManager(), localStorage: DataBaseManager(), keychain: KeychainManager())
        let viewModel = MainViewModel(model: model)
        let mainViewController = MainViewController(mainViewModel: viewModel)
        let settingsModel = SettingsModel(localStorage: DataBaseManager())
        let settingsVewModel = SettingsViewModel(model: settingsModel)
        let secondViewController = SettingsViewController(viewModel: settingsVewModel)
        setupTabBarElement(with: mainViewController, title: L10n.TabbarItem.Title.magic, image: Asset.ball.name)
        setupTabBarElement(with: secondViewController, title: L10n.TabbarItem.Title.history, image: Asset.list.name)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = .black
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
