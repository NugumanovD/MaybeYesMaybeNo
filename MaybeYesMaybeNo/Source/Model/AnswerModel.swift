//
//  AnswerModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/17/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

struct AnswerModel {
    var answer: String
    var timeStamp: Date
}

extension AnswerModel {
     func convertToPresentableAnswer(text: String, time: String) -> PresentableAnswer {
        return PresentableAnswer(text: text, timeStamp: time)
    }
}
