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
    func addItem(with text: PresentableAnswer)
    func deleteItem(item: PresentableAnswer)
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

    func addItem(with text: PresentableAnswer) {
        let answersList = DefaultAnswersModel()
        let currentData = Date()
        answersList.answerDefault = text.text
        answersList.timeStamp = currentData
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    let backgroundRealm = try Realm()
                    try backgroundRealm.write {
                        backgroundRealm.add(answersList)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func deleteItem(item: PresentableAnswer) {
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    let backgroundRealm = try Realm()
                    let dataBaseItems = backgroundRealm.objects(DefaultAnswersModel.self).map({ $0 })
                    for dataBaseItem in dataBaseItems {
                        if dataBaseItem.convertTo().timeStamp == item.timeStamp {
                            try backgroundRealm.write {
                                backgroundRealm.delete(dataBaseItem)
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func migrationRealmDataBase() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
}
