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
    
    let realm = try! Realm()
    
    private init() {}
    
    static func shared() -> DataBaseManager {
        return DataBaseManager()
    }
    
    static func all(in realm: Realm = try! Realm()) -> Results<DefaultAnswersList> {
        return realm.objects(DefaultAnswersList.self)
        
    }
    
    static func add(text: String, in realm: Realm = try! Realm()) {
        
        let answersList = DefaultAnswersList()
        answersList.answerDefault = text
        
        try! realm.write {
            realm.add(answersList)
        }
    }
    
    static func delete(item: DefaultAnswersList, in realm: Realm = try! Realm()) {
        try! realm.write {
            realm.delete(item)
        }
    }


}
