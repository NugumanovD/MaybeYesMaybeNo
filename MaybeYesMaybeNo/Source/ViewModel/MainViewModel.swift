//
//  MainViewModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/29/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MainViewModel {

    // MARK: - Public Properties

    let answerText = BehaviorRelay(value: "Shake Me")
    let shakeCountText = BehaviorRelay(value: L10n.CountLabel.Placeholer.text)
    let didShakenEvent = PublishSubject<Void>()
    let isLoadingDataStateHandler = PublishSubject<Bool>()

    // MARK: - Private Properties

    private let updateShakeCount = BehaviorSubject<PresentableShakeCount?>(value: nil)
    private let reactiveAnswerModel = BehaviorSubject<PresentableAnswer?>(value: nil)
    private let answerModel: MainModel
    private let disposedBag = DisposeBag()

    // MARK: - Init

    init(model: MainModel) {
        self.answerModel = model
        setupBindings()
    }

    // MARK: - Private Function

    private func setupBindings() {
        answerModel.answer.subscribe(onNext: { [weak self] answer in
            guard let answerResult = answer,
                let self = self else { return }
            self.reactiveAnswerModel
                .onNext(answerResult.convertToPresentableAnswer(answer: answerResult))
            self.answerText.accept(answerResult.answer.uppercased())
        }).disposed(by: disposedBag)

        didShakenEvent
            .bind(to: answerModel.didShakenEvent)
            .disposed(by: disposedBag)

        answerModel.updateShakeCounter.subscribe(onNext: { [weak self] (shakeCount) in
            guard let modifiedShakeCountText = shakeCount?.shakeCount,
                let self = self else { return }
            self.updateShakeCount.onNext(shakeCount)
            self.shakeCountText.accept(L10n.CountLabel.Placeholer.text + modifiedShakeCountText)
        }).disposed(by: disposedBag)

        answerModel.isLoadingData
            .bind(to: isLoadingDataStateHandler)
            .disposed(by: disposedBag)
    }

    // MARK: - Public Function

    func requestAnswer() {
        answerModel.requestAnswer()
    }
}
