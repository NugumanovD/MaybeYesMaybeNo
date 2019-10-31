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

    let answerText = BehaviorRelay(value: L10n.AnswerLabel.Placeholder.text)
    let shakeCountText = BehaviorRelay(value: L10n.CountLabel.Placeholer.text)
    let didShakeEvent = PublishSubject<Void>()
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
        answerModel.answer
            .map {$0?.answer.uppercased()}
            .bind(onNext: { [weak self]  answer in
                guard let answerResult = answer, let self = self else { return }
                self.answerText.accept(answerResult)
            }).disposed(by: disposedBag)

        answerModel.answer
            .map {$0?.convertToPresentableAnswer(answer: $0!)}
            .bind(onNext: { [weak self] answer in
                guard let answerResult = answer, let self = self else { return }
                self.reactiveAnswerModel
                    .onNext(answerResult)
        }).disposed(by: disposedBag)

        answerModel.updateShakeCounter.bind(onNext: { [weak self] (shakeCount) in
            guard let modifiedShakeCountText = shakeCount?.shakeCount,
                let self = self else { return }
            self.shakeCountText.accept(L10n.CountLabel.Placeholer.text + modifiedShakeCountText)
        }).disposed(by: disposedBag)

        didShakeEvent
            .bind(to: answerModel.didShakeEvent)
            .disposed(by: disposedBag)

        answerModel.isLoadingData
            .bind(to: isLoadingDataStateHandler)
            .disposed(by: disposedBag)
    }

    // MARK: - Public Function

    func requestAnswer() {
        answerModel.requestAnswer()
    }
}
