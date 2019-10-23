//
//  MainModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/30/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainModel {

    var isLoadingDataStateHandler: ((Bool) -> Void)?

    // MARK: - Private Properties
    private let networker: DataFetching
    private let localStorage: LocalDataStorable
    private let keychainStorage: ShakesCounting
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
    }

    // MARK: - Public Function
     func getAnswer(completion: @escaping (AnswerModel?) -> Void) {
        isLoadingData = true
        networker.request { (result, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(self.localStorage.allItems().randomElement())
                    self.isLoadingData = false
                    print(error.localizedDescription)
                }
                guard let fetchResult = result else {
                    completion(self.localStorage.allItems().randomElement())
                    self.isLoadingData = false
                    return
                }
                self.localStorage.addItem(with: fetchResult.magic.convertTo())
                completion(fetchResult.magic.convertTo())
                self.isLoadingData = false
            }
        }
    }

    func getCount(completion: @escaping (PresentableShakeCount?) -> Void) {
        keychainStorage.getShakesCount { (shakeCount)  in
            guard let shake = shakeCount else { return }
            completion(shake)
        }
    }

    func didShaken() {
        keychainStorage.didShaken()
    }
}
