//
//  DataBaseManager.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/27/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RealmSwift

protocol LocalDataStorable: class {
    func allItems() -> [PresentableAnswer]
    func addItem(text: String)
    func deleteItem(item: String)
}

class DataBaseManager: LocalDataStorable {

    private var realm: Realm!
    init() {
        do {
            try self.realm = Realm()
        } catch {
            self.realm = nil
        }
    }

    func allItems() -> [PresentableAnswer] {
        return realm.objects(DefaultAnswersModel.self).map({ $0.convertTo() })
    }

    func addItem(text: String) {
        let answersList = DefaultAnswersModel()
        let currentData = Date()
        answersList.answerDefault = text
        answersList.timeStamp = currentData
            try? realm.write {
                realm.add(answersList)
        }
    }

    func deleteItem(item: String) {
        let elementsLocalStorage = realm.objects(DefaultAnswersModel.self)
        for currentItem in elementsLocalStorage where currentItem.answerDefault == item {
            try? self.realm.write {
                self.realm.delete(currentItem)
            }
        }
    }
}
