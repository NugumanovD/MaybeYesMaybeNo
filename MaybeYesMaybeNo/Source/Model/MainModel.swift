//
//  MainModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/30/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

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
    func getAnswer(completion: @escaping (String?) -> Void) {
        networker.request { (result, error) in
            let localDatabaseAnswer = self.localStorage.allItems().randomElement()
            if let error = error {
//                completion(localDatabaseAnswer?.answerDefault)
                print(error.localizedDescription)
            }
            guard let fetchResult = result else {
//                completion(localDatabaseAnswer?.answerDefault)
                return
            }
            completion(fetchResult.magic.answer)
        }
    }
}
