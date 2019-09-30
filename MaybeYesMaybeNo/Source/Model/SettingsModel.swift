//
//  SettingsModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/1/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class SettingsModel {
    private let localStorage: LocalStorable

    init(_ localStorage: LocalStorable) {
        self.localStorage = localStorage
    }

    func addCustomAnswer(with text: String) {
        localStorage.add(text: text, in: localStorage.realm)
    }

    func numberOfRows() -> Int {
        let itemsResults = localStorage.all(in: localStorage.realm)
        return itemsResults.count
    }

    func localStorageItems() -> Results<DefaultAnswersModel> {
        return localStorage.realm.objects(DefaultAnswersModel.self)
    }

    func realm() -> Realm {
        return localStorage.realm
    }

    func deleteItemInRealm(with item: DefaultAnswersModel) {
        localStorage.delete(item: item, in: localStorage.realm)
    }

    func addItemInRealm(with text: String, realm: Realm) {
        localStorage.add(text: text, in: realm)
    }
}
