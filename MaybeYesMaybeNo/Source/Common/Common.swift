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
    static let url = L10n.Link.url
    static let question = L10n.Link.path
}

enum Screen {
    static let settingsView = L10n.Screen.settingsView
}

enum Cell {
    static let identifier = L10n.Cell.identifier
}
