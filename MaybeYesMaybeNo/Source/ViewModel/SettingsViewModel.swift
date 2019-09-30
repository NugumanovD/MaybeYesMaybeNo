//
//  SettingsViewModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/1/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RealmSwift

class SettingsViewModel {
    private let settingsModel: SettingsModel

    init(_ model: SettingsModel) {
        self.settingsModel = model
    }

    func numberOfRows() -> Int {
        return settingsModel.numberOfRows()
    }

    func dataBaseStorage() -> Results<DefaultAnswersModel> {
        return settingsModel.localStorageItems()
    }

    func realm() -> Realm {
        return settingsModel.realm()
    }

    func removeItem(from dataBase: DefaultAnswersModel) {
        return settingsModel.deleteItemInRealm(with: dataBase)
    }

    func addItem(with text: String) {
        settingsModel.addCustomAnswer(with: text)
    }
}
