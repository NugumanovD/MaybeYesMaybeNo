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
    func convertTo() -> PresentableAnswer {
        let formatter = DateFormatter()
               formatter.timeStyle = .medium
               formatter.dateStyle = .medium
        let timeStampString = formatter.string(from: timeStamp)
        return PresentableAnswer(text: answerDefault, timeStamp: timeStampString)
    }
}
