//
//  MainModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/30/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainModel {

    // MARK: - Public Properties
    var answerEntity: Magic? {
        didSet {
            guard let answer = answerEntity else {
                print("Oops")
                return
            }
            print(answer)
        }
    }

    // MARK: - Private Properties
    private let networker: DataManagerProtocol

    // MARK: - Init
    init(_ networker: DataManagerProtocol) {
        self.networker = networker
    }

    // MARK: - Public Function
    func getAnswer(completion: @escaping CompletionHandler) {
        networker.request { (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            guard let answer = result else { return }
            completion(answer, nil)
            self.answerEntity = answer.magic
        }
    }
    
}
