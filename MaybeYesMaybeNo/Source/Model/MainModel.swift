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
    private let networker: DataManagerProtocol
    private let localStorage: LocalStorable

    // MARK: - Init
    init(networker: DataManagerProtocol, localStorage: LocalStorable) {
        self.networker = networker
        self.localStorage = localStorage
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
                completion(fetchResult.magic.convertToPresentable())
            }
        }
    }
}
