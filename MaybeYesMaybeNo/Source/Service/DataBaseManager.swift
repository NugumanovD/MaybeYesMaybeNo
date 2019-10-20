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
    func allItems() -> [AnswerModel]
    func addItem(with text: AnswerModel)
    func deleteItem(item: AnswerModel)
}

class DataBaseManager: LocalDataStorable {

    private var realm: Realm!
    init() {
        migrationRealmDataBase()
        do {
            try self.realm = Realm()
        } catch {
            self.realm = nil
        }
    }

    func allItems() -> [AnswerModel] {
        return realm.objects(DefaultAnswersModel.self).map({ $0.convertToAnswerModel() })
    }

    func addItem(with text: AnswerModel) {
        DispatchQueue.global().async {
            autoreleasepool {
                let answersList = DefaultAnswersModel()
                answersList.answerDefault = text.answer
                answersList.identifier = UUID().uuidString
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

    func deleteItem(item: AnswerModel) {
        DispatchQueue.global().async {
            autoreleasepool {
                do {
                    let backgroundRealm = try Realm()
                    guard let identifier = item.identifier else { return }
                    let dataBaseItems = backgroundRealm.objects(DefaultAnswersModel.self)
                        .filter("identifier == %@", identifier)
                    try backgroundRealm.write {
                        backgroundRealm.delete(dataBaseItems)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func migrationRealmDataBase() {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { _, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                }
        })
        Realm.Configuration.defaultConfiguration = config
    }
}
