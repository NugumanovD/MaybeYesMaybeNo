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
    var identifier: String?
}

extension AnswerModel {
    func convertToPresentableAnswer(answer: AnswerModel) -> PresentableAnswer {
        return PresentableAnswer(text: answer.answer,
                                 timeStamp: answer.timeStamp,
                                 identifier: answer.identifier ?? ""
        )
    }
}
