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
    lazy var formmater = DateFormatter()
    init(model: SettingsModel) {
        self.settingsModel = model
    }

    func numberOfRows() -> Int {
        return settingsModel.numberOfRows()
    }

    func dataBaseStorage() -> [PresentableAnswer] {
        let items = settingsModel.localStorageItems().map {
            $0.convertToPresentableAnswer(text: $0.answer, time: convert(date: $0.timeStamp))
        }
        return items.sorted { $0.timeStamp > $1.timeStamp}
    }

    func removeItem(_ dataBase: PresentableAnswer) {
        let answerModel = AnswerModel(answer: dataBase.text, timeStamp: reverseConvertTo(string: dataBase.timeStamp))
        return settingsModel.deleteItem(answerModel)
    }

    func addItem(with property: PresentableAnswer) {
        settingsModel.addCustomAnswer(property.convertToAnswerModel())
    }

     func convert(date: Date) -> String {
        formmater.timeStyle = .medium
        formmater.dateStyle = .medium
        let dateString = formmater.string(from: date)
        return dateString
    }

     private func reverseConvertTo(string: String) -> Date {
        formmater.timeStyle = .medium
        formmater.dateStyle = .medium
        let date = formmater.date(from: string)
        guard let test = date  else { return Date()}
        return test
    }
}
