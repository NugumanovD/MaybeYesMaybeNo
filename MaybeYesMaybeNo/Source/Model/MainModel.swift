//
//  MainModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/30/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainModel {

    // MARK: - Private Properties
    private let networker: DataFetching
    private let localStorage: LocalDataStorable
    private let keychainStorage: ShakesCounting

    // MARK: - Init
    init(networker: DataFetching, localStorage: LocalDataStorable, keychain: ShakesCounting) {
        self.networker = networker
        self.localStorage = localStorage
        self.keychainStorage = keychain
    }

    // MARK: - Public Function
     func getAnswer(completion: @escaping (PresentableAnswer?) -> Void) {
        networker.request { (result, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(self.localStorage.allItems().randomElement())
                    print(error.localizedDescription)
                }
                guard let fetchResult = result else {
                    completion(self.localStorage.allItems().randomElement())
                    return
                }
                self.localStorage.addItem(text: fetchResult.magic.answer)
                completion(fetchResult.magic.convertToPresentable())
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
