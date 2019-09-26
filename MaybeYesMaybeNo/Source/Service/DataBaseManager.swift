//
//  DataBaseManager.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/27/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseManager {
    func all(in realm: Realm) -> Results<DefaultAnswersModel> {
        return realm.objects(DefaultAnswersModel.self)
    }
    // swiftlint:disable:next force_try
    func add(text: String, in realm: Realm = try! Realm()) {
        let answersList = DefaultAnswersModel()
        answersList.answerDefault = text

        try? realm.write {
            realm.add(answersList)
        }
    }

    func delete(item: DefaultAnswersModel, in realm: Realm) {
        try? realm.write {
            realm.delete(item)
        }
    }
}
