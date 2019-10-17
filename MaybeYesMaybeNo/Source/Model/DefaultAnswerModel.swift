//
//  DefaultAnswerModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/27/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RealmSwift

class DefaultAnswersModel: Object {

    @objc dynamic var answerDefault = L10n.DefaultAnswer.type
    @objc dynamic var timeStamp = Date()
}

extension DefaultAnswersModel {
    func convertToAnswerModel() -> AnswerModel {
        return AnswerModel(answer: answerDefault, timeStamp: timeStamp)
    }
}
