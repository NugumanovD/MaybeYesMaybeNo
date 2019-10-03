//
//  ViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet private var answerLabel: UILabel!
    @IBOutlet private var settingsButton: UIButton!

    private var mainViewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingsButton()
    }

    func attach(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch motion {
        case .motionShake:
            mainViewModel?.getAnswer(completion: { [weak self] answer in
                DispatchQueue.main.async {
                    self?.answerLabel.text = answer?.text.uppercased()
                }
            })
        default:
            break
        }
    }

    @IBAction private func presentSettingsScreen(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Storyboard.main, bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: Screen.settingsView)
            as? SettingsViewController
        let model = SettingsModel(localStorage: DataBaseManager())
        let settingsVewModel = SettingsViewModel(model: model)
        secondViewController?.attach(viewModel: settingsVewModel)
        guard let settingsViewController = secondViewController else { return }
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

    private func configureSettingsButton() {
        settingsButton.clipsToBounds = true
        settingsButton.layer.cornerRadius = settingsButton.bounds.size.width / 2
        let image = UIImage(named: Asset.settings.name)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(tintedImage, for: .normal)
    }
}
