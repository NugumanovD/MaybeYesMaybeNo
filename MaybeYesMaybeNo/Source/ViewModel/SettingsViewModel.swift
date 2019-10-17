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

    func dataBaseStorage() -> [PresentableAnswer] {
        return settingsModel.localStorageItems().sorted { $0.timeStamp > $1.timeStamp }
    }

    func removeItem(_ dataBase: PresentableAnswer) {
        return settingsModel.deleteItem(dataBase)
    }

    func addItem(with property: PresentableAnswer) {
        settingsModel.addCustomAnswer(property)
    }
}
