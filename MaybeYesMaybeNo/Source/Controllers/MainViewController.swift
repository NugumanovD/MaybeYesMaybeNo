//
//  ViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {

    let answerLabel = UILabel()
    let triangleImageView = UIImageView()
    let settingsButton = UIButton()

    private var mainViewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTriangleImageView()
        configureAnswerLabel()
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

    private func configureSettingsButton() {
        self.view.addSubview(settingsButton)
        let image = UIImage(named: Asset.settings.name)
        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        settingsButton.setImage(tintedImage, for: .normal)
        settingsButton.addTarget(self, action: #selector(presentSettingsScreen(_:)), for: .touchUpInside)
        configureSettingsButtonConstaraints()
    }

    func configureSettingsButtonConstaraints() {
        let safeAreaView = self.view.safeAreaLayoutGuide
        settingsButton.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
            make.bottom.equalTo(safeAreaView.snp.bottom).offset(-20)
            make.left.equalTo(safeAreaView.snp.left).offset(20)
        }
    }

    func configureTriangleImageView() {
        self.view.addSubview(triangleImageView)
        triangleImageView.image = UIImage(named: Asset.triangle.name)
        configureTriangleImageConstaints()
    }

    func configureTriangleImageConstaints() {
        triangleImageView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func configureAnswerLabel() {
        answerLabel.text = L10n.AnswerLabel.Placeholder.text
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 4
        answerLabel.font = UIFont(name: "Helvetica Neue", size: 25)
        self.triangleImageView.addSubview(answerLabel)
        configureAnswerLabelConstraints()
    }

    func configureAnswerLabelConstraints() {
        answerLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(152)
            make.centerX.equalTo(triangleImageView.snp.centerX)
            make.top.equalTo(triangleImageView.snp.top).offset(22)
        }
    }

    @objc private func presentSettingsScreen(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: Storyboard.main, bundle: nil)
//        let secondViewController = storyboard.instantiateViewController(withIdentifier: Screen.settingsView)
//            as? SettingsViewController
        let secondViewController = SettingsViewController()
        let model = SettingsModel(localStorage: DataBaseManager())
        let settingsVewModel = SettingsViewModel(model: model)
        secondViewController.attach(viewModel: settingsVewModel)
//        guard let settingsViewController = secondViewController else { return }
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
