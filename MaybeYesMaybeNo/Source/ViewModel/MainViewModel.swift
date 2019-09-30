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
    
    func getAnswer(completion: @escaping CompletionHandler) {
        answerModel.getAnswer { (answer, error) in
            print(answer)
            completion(answer, nil)
        }
        
    }
    
//    func answer(completion: @escaping (Magic?) -> Void) {
//        let fetchAnswer = answerModel.answerEntity
//        completion(fetchAnswer)
//    }
//
}
