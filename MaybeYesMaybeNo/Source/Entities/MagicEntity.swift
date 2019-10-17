//
//  MagicEntity.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/30/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

struct Magic: Codable {
    var answer: String
}

extension Magic {
    func convertTo() -> AnswerModel {
        return AnswerModel(answer: answer, timeStamp: Date())
    }
}
