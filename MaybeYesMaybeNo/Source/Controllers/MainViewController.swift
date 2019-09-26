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

    private let requestManager = NetworkManager()
    // swiftlint:disable:next force_try
    private let realm = try! Realm()
    private var items: Results<DefaultAnswersModel>!
    private let dataBase = DataBaseManager()

    @IBOutlet private var answerLabel: UILabel!
    @IBOutlet private var settingsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSettingsButton()
        items = dataBase.all(in: realm)
    }

    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            getAnswer()
        }
    }

    @IBAction private func presentSettingsScreen(_ sender: UIButton) {
        navigationController?.pushViewController(transitionToController(with: Screen.settingsView), animated: true)
    }

    private func getAnswer() {
        requestManager.fetchAnswer { [weak self] (result, error) in

            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self?.answerLabel.text = self?.items.randomElement()?.answerDefault
                }
                return
            }

            guard let answer = result?.magic.answer else {
                self?.answerLabel.text = self?.items.randomElement()?.answerDefault
                return
            }

            DispatchQueue.main.async {
                self?.answerLabel.text = answer
            }
        }
    }

    private func configureSettingsButton() {
        settingsButton.clipsToBounds = true
        settingsButton.layer.cornerRadius = settingsButton.bounds.size.width / 2
        let image = UIImage(named: Asset.settings.name)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(tintedImage, for: .normal)

    }

}
