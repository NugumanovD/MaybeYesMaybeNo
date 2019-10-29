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
    let didShakenEvent = PublishSubject<Void>()
    let getShakeCount = PublishSubject<Void>()
    let isLoadingData = BehaviorSubject<Bool>(value: false)

    // MARK: - Private Properties

    private let networker: DataFetching
    private let localStorage: LocalDataStorable
    private let keychainStorage: ShakesCounting
    private let disposebag = DisposeBag()

    // MARK: - Init

    init(networker: DataFetching, localStorage: LocalDataStorable, keychain: ShakesCounting) {
        self.networker = networker
        self.localStorage = localStorage
        self.keychainStorage = keychain
        setupBindigs()
    }

    // MARK: - Private Function

    private func setupBindigs() {
        getShakeCount.asObserver().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.updateShakeCounter.onNext(self.keychainStorage.getShakeCount())
        }).disposed(by: disposebag)

        didShakenEvent.asObserver().subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.keychainStorage.didShaken()
            self.updateShakeCounter.onNext(self.keychainStorage.getShakeCount())
        }).disposed(by: disposebag)
    }

    // MARK: - Public Function

    func requestAnswer() {
        isLoadingData.onNext(true)
        networker.request { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.answer.onNext(self.localStorage.allItems().randomElement())
                }
                self.isLoadingData.onNext(false)
                print(error.localizedDescription)
            }
            guard let fetchingResult = result else {
                DispatchQueue.main.async {
                    self.answer.onNext(self.localStorage.allItems().randomElement())
                }
                self.isLoadingData.onNext(false)
                return
            }
            self.answer.onNext(fetchingResult.magic.convertTo())
            self.localStorage.addItem(with: fetchingResult.magic.convertTo())
            self.isLoadingData.onNext(false)
        }
    }
}
