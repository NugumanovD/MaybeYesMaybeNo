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

    var isLoadingDataStateHandler: ((Bool) -> Void)?
    let answer = BehaviorSubject<AnswerModel?>(value: nil)
    let updateShakeCounter = BehaviorSubject<PresentableShakeCount?>(value: nil)
    let requestShakeCounter = PublishSubject<Void>()
    let didShakenEvent = PublishSubject<Void>()
    
    // MARK: - Private Properties
    private let networker: DataFetching
    private let localStorage: LocalDataStorable
    private let keychainStorage: ShakesCounting
    private let disposebag = DisposeBag()

    private var isLoadingData = false {
        didSet {
            isLoadingDataStateHandler?(isLoadingData)
        }
    }

    // MARK: - Init
    init(networker: DataFetching, localStorage: LocalDataStorable, keychain: ShakesCounting) {
        self.networker = networker
        self.localStorage = localStorage
        self.keychainStorage = keychain
        setupBindigs()
    }

    func setupBindigs() {
        requestShakeCounter.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.updateShakeCounter.onNext(self.keychainStorage.getShakeCount())
        }).disposed(by: disposebag)
        
        didShakenEvent.asObserver().subscribe(onNext: { _ in
            self.keychainStorage.didShaken()
        }).disposed(by: disposebag)
    }
    
    // MARK: - Public Function

    func requestAnswer() {
        isLoadingData = true
        networker.request { [weak self] (result, error) in
            guard let self = self else { return }
            if let error = error {
                DispatchQueue.main.async {
                    self.answer.onNext(self.localStorage.allItems().randomElement())
                }
                self.isLoadingData = false
                print(error.localizedDescription)
            }
            guard let fetchingResult = result else {
                DispatchQueue.main.async {
                    self.answer.onNext(self.localStorage.allItems().randomElement())
                }
                self.isLoadingData = false
                return
            }
            self.answer.onNext(fetchingResult.magic.convertTo())
            self.localStorage.addItem(with: fetchingResult.magic.convertTo())
            self.isLoadingData = false
        }
    }
    
    func getCount(completion: @escaping (PresentableShakeCount?) -> Void) {
        keychainStorage.getShakesCount { (shakeCount)  in
            guard let shake = shakeCount else { return }
            completion(shake)
        }
    }
}
