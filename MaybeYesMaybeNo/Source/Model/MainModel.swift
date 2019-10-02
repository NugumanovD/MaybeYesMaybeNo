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

    func defaultAnswer() -> String {
        let localDatabaseAnswer = self.localStorage.allItems().randomElement()
        guard let defaultAnswer = localDatabaseAnswer?.answerDefault else { return "" }
        return defaultAnswer
    }

    // MARK: - Public Function
    func getAnswer(completion: @escaping (String?) -> Void) {
        networker.request { (result, error) in
            if let error = error {
                completion(self.defaultAnswer())
                print(error.localizedDescription)
            }
            guard let fetchResult = result else {
                completion(self.defaultAnswer())
                return
            }
            completion(fetchResult.magic.answer)
        }
    }
}
