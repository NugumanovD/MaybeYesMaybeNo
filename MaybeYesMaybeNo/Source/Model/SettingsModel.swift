//
//  SettingsModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/1/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class SettingsModel {
    private let localStorage: LocalStorable

    init(localStorage: LocalStorable) {
        self.localStorage = localStorage
    }

    func addCustomAnswer(with text: String) {
        localStorage.addItem(text: text)
    }

    func numberOfRows() -> Int {
        return localStorage.allItems().count
    }

    func localStorageItems() -> [String] {
        return localStorage.allItems().compactMap({ $0.answerDefault })
    }

    func deleteItemInRealm(with item: String) {
        localStorage.deleteItem(item: item)
    }

    func addItemInRealm(with text: String) {
        localStorage.addItem(text: text)
    }
}
