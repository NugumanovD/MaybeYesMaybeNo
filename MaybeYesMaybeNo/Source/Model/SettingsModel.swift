//
//  SettingsModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/1/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class SettingsModel {
    private let localStorage: LocalDataStorable

    init(localStorage: LocalDataStorable) {
        self.localStorage = localStorage
    }

    func addCustomAnswer(_ answer: PresentableAnswer) {
        localStorage.addItem(with: answer)
    }

    func numberOfRows() -> Int {
        return localStorage.allItems().count
    }

    func localStorageItems() -> [PresentableAnswer] {
        return localStorage.allItems().compactMap({ $0 })
    }

    func deleteItem(_ item: PresentableAnswer) {
        localStorage.deleteItem(item: item)
    }

}
