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
    private let shakesCounterLabel = UILabel()
    private var mainViewModel: MainViewModel

    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTriangleImageView()
        configureAnswerLabel()
        configureShakesCounterLabel()
        fetchShakesCount()
        navigationItem.title = L10n.TabbarItem.Title.magic
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch motion {
        case .motionShake:
            mainViewModel.didShaken()
            mainViewModel.getAnswer(completion: { [weak self] answer in
                DispatchQueue.main.async {
                    self?.answerLabel.text = answer?.text
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
        shakesCounterLabel.font = UIFont(name: Fonts.helveticaNeue, size: 20)
        shakesCounterLabel.textColor = .systemBlue
        self.view.addSubview(shakesCounterLabel)
        configureCounterLabelConstraints()
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
}
