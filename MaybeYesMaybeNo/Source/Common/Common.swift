//
//  Common.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    case badURL
    case api(error: Swift.Error)
    case incorrectModel
}

enum Link {
    static let url = "https://8ball.delegator.com/magic/JSON/"
    static let question = "question"
}
