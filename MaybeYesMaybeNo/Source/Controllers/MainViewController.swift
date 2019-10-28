//
//  ViewController.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {

    // MARK: - Private Properties

    private let answerLabel = UILabel()
    private let triangleImageView = UIImageView()
    private let shakesCounterLabel = UILabel()
    private var mainViewModel: MainViewModel
    private var shouldRestartAnimation = BehaviorRelay(value: true)
    private let disposedBag = DisposeBag()

    // MARK: - Init

    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
        tabBarItem.title = L10n.TabbarItem.Title.magic
        tabBarItem.image = Asset.ball.image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTriangleImageView()
        configureAnswerLabel()
        configureShakesCounterLabel()
        navigationItem.title = L10n.TabbarItem.Title.magic
        setupBindings()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        switch motion {
        case .motionShake:
            rotationAnimation()
            clearAnswerLabel()
            mainViewModel.requestAnswer()
            didShaken()
        default:
            break
        }
    }

    // MARK: - Private Function

    private func setupBindings() {
        mainViewModel.answerText
            .asObservable().bind(to: answerLabel.rx.text)
            .disposed(by: disposedBag)

        mainViewModel.shakeCountText
            .asObservable().bind(to: shakesCounterLabel.rx.text)
            .disposed(by: disposedBag)

        mainViewModel.isLoadingDataStateHandler
            .asObservable()
            .bind(to: shouldRestartAnimation)
            .disposed(by: disposedBag)
    }

    private func didShaken() {
        mainViewModel.didShakenEvent.onNext(())
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

    private func rotationAnimation() {
        UIView.transition(
            with: self.triangleImageView,
            duration: 0.5,
            options: .transitionFlipFromLeft,
            animations: {
        }, completion: { _ in
            if self.shouldRestartAnimation.value {
                self.rotationAnimation()
            }
        })
    }

    private func clearAnswerLabel() {
        answerLabel.text = ""
    }
}
