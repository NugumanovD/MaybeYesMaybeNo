//
//  PresentableModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/3/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RxDataSources

class PresentableAnswer: IdentifiableType, Equatable {
    typealias Identity = String

    var identity: Identity { return identifier }

    static func == (lhs: PresentableAnswer, rhs: PresentableAnswer) -> Bool {
        lhs.identifier == rhs.identifier
    }

    var text: String
    var timeStamp: Date
    var identifier: String

    init(text: String, timeStamp: Date, identifier: String) {
        self.text = text
        self.timeStamp = timeStamp
        self.identifier = identifier
    }
}

extension PresentableAnswer {
    func convertToAnswerModel() -> AnswerModel {
        return AnswerModel(answer: text, timeStamp: timeStamp, identifier: identifier)
    }
}
