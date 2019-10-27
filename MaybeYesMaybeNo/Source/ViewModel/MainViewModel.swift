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
    let text = BehaviorRelay(value: "Shake Me")
    let reactiveAnswerModel = BehaviorSubject<PresentableAnswer?>(value: nil)
    let didUpdateCounter = BehaviorSubject<PresentableShakeCount?>(value: nil)
    let getShakeCount = BehaviorSubject<PresentableShakeCount?>(value: nil)
    
    var shouldAnimateLoadingStateHandler: ((Bool) -> Void)? {
        didSet {
            answerModel.isLoadingDataStateHandler = shouldAnimateLoadingStateHandler
        }
    }

    let didShakenEvent = PublishSubject<Void>()

    private let answerModel: MainModel
    private let disposedBag = DisposeBag()

    init(model: MainModel) {
        self.answerModel = model
        setupBindings()
    }

    private func setupBindings() {
        answerModel.answer.subscribe(onNext: { [weak self] answer in
            guard let answerResult = answer,
                  let self = self else { return }
            self.reactiveAnswerModel
                .onNext(answerResult.convertToPresentableAnswer(answer: answerResult))
            self.text.accept(answerResult.answer.uppercased())
        }).disposed(by: disposedBag)
        
        didShakenEvent
            .bind(to: answerModel.didShakenEvent)
            .disposed(by: disposedBag)
    }

    func requestAnswer() {
        answerModel.requestAnswer()
    }

    func getShakeCount(completion: @escaping (PresentableShakeCount?) -> Void) {
        answerModel.getCount { (shake) in
            guard let shake = shake else { return }
            completion(shake)
        }
    }
}
