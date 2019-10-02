//
//  SettingsViewModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/1/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class SettingsViewModel {
    private let settingsModel: SettingsModel

    init(model: SettingsModel) {
        self.settingsModel = model
    }

    func numberOfRows() -> Int {
        return settingsModel.numberOfRows()
    }

    func dataBaseStorage() -> [String] {
        return settingsModel.localStorageItems()
    }

    func removeItem(from dataBase: String) {
        return settingsModel.deleteItemInRealm(with: dataBase)
    }

    func addItem(with text: String) {
        settingsModel.addCustomAnswer(with: text)
    }
}
