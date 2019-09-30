//
//  ViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: BaseViewController {

    @IBOutlet private var answerLabel: UILabel!
    @IBOutlet private var settingsButton: UIButton!

    var mainViewModel: MainViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func attach(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            mainViewModel?.getAnswer(completion: { (answer) in
                DispatchQueue.main.async {
                    self.answerLabel.text = answer
                }
            })
        }
    }

    @IBAction private func presentSettingsScreen(_ sender: UIButton) {
        navigationController?.pushViewController(transitionToController(with: Screen.settingsView), animated: true)
    }

    private func configureSettingsButton() {
        settingsButton.clipsToBounds = true
        settingsButton.layer.cornerRadius = settingsButton.bounds.size.width / 2
        let image = UIImage(named: Asset.settings.name)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(tintedImage, for: .normal)

    }

}
