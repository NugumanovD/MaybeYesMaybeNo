//
//  MainViewModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/29/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainViewModel {
    private let answerModel: MainModel

    init(_ model: MainModel) {
        self.answerModel = model
    }

    func getAnswer(completion: @escaping (String?) -> Void) {
        answerModel.getAnswer { (answer) in
            completion(answer)
        }
    }
}
