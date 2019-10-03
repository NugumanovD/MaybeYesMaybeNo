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

    init(model: MainModel) {
        self.answerModel = model
    }

    func getAnswer(completion: @escaping (PresentableAnswer?) -> Void) {
        answerModel.getAnswer { answer in
            guard let answerResult = answer else { return }
            completion(answerResult)
        }
    }
}
