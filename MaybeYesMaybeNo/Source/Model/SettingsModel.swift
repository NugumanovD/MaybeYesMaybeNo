//
//  SettingsModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/1/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RxSwift

class SettingsModel {
    let addAnswer = PublishSubject<AnswerModel>()
    let allDataStorage = PublishSubject<[PresentableAnswer]>()
    let deletingEvent = PublishSubject<AnswerModel>()
    private let disposeBag = DisposeBag()
    private let localStorage: LocalDataStorable

    init(localStorage: LocalDataStorable) {
        self.localStorage = localStorage
        setupBindings()
    }

    private func setupBindings() {
        deletingEvent.bind(onNext: { [weak self] (answerModel) in
            self?.deleteItem(answerModel)
        }).disposed(by: disposeBag)
        addAnswer.bind(onNext: { [weak self] addAnswer in
            self?.addCustomAnswer(addAnswer)
        }).disposed(by: disposeBag)
    }
    func addCustomAnswer(_ answer: AnswerModel) {
        localStorage.addItem(with: answer)
    }

    func getlocalStorageItems() {
        let items = localStorage.allItems()
            .compactMap({ $0.convertToPresentableAnswer(answer: $0) })
        let sortedItems = items.sorted { $0.timeStamp > $1.timeStamp }
        allDataStorage.onNext(sortedItems)
    }

    func deleteItem(_ item: AnswerModel) {
        localStorage.deleteItem(item: item)
    }
}
