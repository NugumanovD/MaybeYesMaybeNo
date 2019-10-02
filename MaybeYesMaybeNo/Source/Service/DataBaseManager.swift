//
//  DataBaseManager.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/27/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RealmSwift

protocol LocalStorable: class {
    func allItems() -> Results<DefaultAnswersModel>
    func addItem(text: String)
    func deleteItem(item: String)
}

class DataBaseManager: LocalStorable {

    var realm: Realm!
    init() {
        do {
            try self.realm = Realm()
        } catch {
            self.realm = nil
        }
    }

    func allItems() -> Results<DefaultAnswersModel> {
        return realm.objects(DefaultAnswersModel.self)
    }

    func addItem(text: String) {
        let answersList = DefaultAnswersModel()
        answersList.answerDefault = text
        try? self.realm.write {
            self.realm.add(answersList)
        }
    }

    func deleteItem(item: String) {
        let elementsLocalStorage = realm.objects(DefaultAnswersModel.self)
        for currentItem in elementsLocalStorage {
            if currentItem.answerDefault == item {
                try? self.realm.write {
                    self.realm.delete(currentItem)
                }
            }
        }
    }
}
