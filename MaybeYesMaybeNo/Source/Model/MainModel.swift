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
    init(_ networker: DataManagerProtocol, localStorage: LocalStorable) {
        self.networker = networker
        self.localStorage = localStorage
    }

    // MARK: - Public Function
    func getAnswer(completion: @escaping CompletionHandler) {
        networker.request { (result, error) in
            if let error = error {
                DispatchQueue.main.async {
                    let localDatabaseAnswer = self.localStorage.all(in: self.localStorage.realm).randomElement()
//                    completion(localDatabaseAnswer, nil)
                }
                print(error.localizedDescription)
            }
            guard let answer = result else { return }
            completion(answer, nil)
//            self.answerEntity = answer.magic
        }
    }
}
