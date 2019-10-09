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

    private let answerLabel = UILabel()
    private let triangleImageView = UIImageView()
    private let settingsButton = UIButton()
    private let shakesCounterLabel = UILabel()
    private var mainViewModel: MainViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTriangleImageView()
        configureAnswerLabel()
        configureSettingsButton()
        configureShakesCounterLabel()
        fetchShakesCount()
    }

    func attach(viewModel: MainViewModel) {
        self.mainViewModel = viewModel
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch motion {
        case .motionShake:
            mainViewModel.didShaken()
            mainViewModel?.getAnswer(completion: { [weak self] answer in
                DispatchQueue.main.async {
                    self?.answerLabel.text = answer?.text.uppercased()
                }
            })
        default:
            break
        }
        fetchShakesCount()
    }

    func fetchShakesCount() {
        mainViewModel.getShakeCount { [weak self] shakes in
            guard let shake = shakes else { return }
            self?.shakesCounterLabel.text =
                L10n.CountLabel.Placeholer.text + shake.shakeCount
        }
    }

    private func configureShakesCounterLabel() {
        //        shakesCounterLabel.textAlignment = .center
        shakesCounterLabel.font = UIFont(name: Fonts.helveticaNeue, size: 20)
        shakesCounterLabel.textColor = .systemBlue
        self.view.addSubview(shakesCounterLabel)
        configureCounterLabelConstraints()
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

    private func configureTriangleImageView() {
        self.view.addSubview(triangleImageView)
        triangleImageView.image = UIImage(named: Asset.triangle.name)
        configureTriangleImageConstaints()
    }

    private func configureTriangleImageConstaints() {
        triangleImageView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    private func configureAnswerLabel() {
        answerLabel.text = L10n.AnswerLabel.Placeholder.text
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 4
        answerLabel.font = UIFont(name: Fonts.helveticaNeue, size: 25)
        self.triangleImageView.addSubview(answerLabel)
        configureAnswerLabelConstraints()
    }

    private func configureAnswerLabelConstraints() {
        answerLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(152)
            make.centerX.equalTo(triangleImageView.snp.centerX)
            make.top.equalTo(triangleImageView.snp.top).offset(22)
        }
    }
    private func configureCounterLabelConstraints() {
        let safeAreaView = self.view.safeAreaLayoutGuide
        shakesCounterLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(200)
            make.top.equalTo(safeAreaView.snp.top).offset(5)
            make.left.equalTo(safeAreaView.snp.left).offset(5)
        }
    }

    @objc private func presentSettingsScreen(_ sender: UIButton) {
        let secondViewController = SettingsViewController()
        let model = SettingsModel(localStorage: DataBaseManager())
        let settingsVewModel = SettingsViewModel(model: model)
        secondViewController.attach(viewModel: settingsVewModel)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
