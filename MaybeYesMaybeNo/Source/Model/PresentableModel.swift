//
//  PresentableModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/3/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

struct PresentableAnswer {
    var text: String
    var timeStamp: Date
    var identifier: String
}

extension PresentableAnswer {
    func convertToAnswerModel() -> AnswerModel {
        return AnswerModel(answer: text, timeStamp: timeStamp)
    }
}
