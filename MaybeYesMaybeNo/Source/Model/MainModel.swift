//
//  MainModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/30/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RxSwift

class MainModel {

    // MARK: - Public Properties

    var isLoadingDataStateHandler: ((Bool) -> Void)?
    let answer = PublishSubject<AnswerModel?>()
    let updateShakeCounter = PublishSubject<PresentableShakeCount?>()
    let didShakeEvent = PublishSubject<Void>()
    let getShakeCount = PublishSubject<Void>()
    let isLoadingData = BehaviorSubject<Bool>(value: false)

    // MARK: - Private Properties

    private let networker: DataFetching
    private let localStorage: LocalDataStorable
    private let keychainStorage: ShakesCounting
    private let disposeBag = DisposeBag()

    // MARK: - Init

    init(networker: DataFetching, localStorage: LocalDataStorable, keychain: ShakesCounting) {
        self.networker = networker
        self.localStorage = localStorage
        self.keychainStorage = keychain
        setupBindigs()
    }

    // MARK: - Private Function

    private func setupBindigs() {

        didShakeEvent
            .bind(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.keychainStorage.didShake()
        }).disposed(by: disposeBag)

        didShakeEvent.asObserver()
            .bind(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.updateShakeCounter.onNext(self.keychainStorage.getShakeCount())
        }).disposed(by: disposeBag)
    }

    // MARK: - Public Function

    func requestAnswer() {
        isLoadingData.onNext(true)
        networker.request { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.sync {
                    self.answer.onNext(self.localStorage.allItems().randomElement())
                }
                self.isLoadingData.onNext(false)
                print(error.localizedDescription)
            }
            guard let fetchingResult = result else {
                DispatchQueue.main.sync {
                    self.answer.onNext(self.localStorage.allItems().randomElement())
                }
                self.isLoadingData.onNext(false)
                return
            }
            let fetchResult = fetchingResult.magic.convertToAnswerModel()
            self.answer.onNext(fetchResult)
            self.localStorage.addItem(with: fetchResult)
            self.isLoadingData.onNext(false)
        }
    }
}
