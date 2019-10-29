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
    let answers = [PresentableAnswer]()
    let allDataStorage = PublishSubject<[PresentableAnswer]>()
    let deletingEvent = PublishSubject<AnswerModel>()
    private let disposeBag = DisposeBag()
    private let localStorage: LocalDataStorable

    init(localStorage: LocalDataStorable) {
        self.localStorage = localStorage
        setupBindings()
    }

    private func setupBindings() {
        deletingEvent.asObservable().subscribe(onNext: { [weak self] (answerModel) in
            guard let self = self else { return }
            self.deleteItem(answerModel)
        }).disposed(by: disposeBag)

    }
    func addCustomAnswer(_ answer: AnswerModel) {
        localStorage.addItem(with: answer)
    }

    func localStorageItems() {
        let items = localStorage.allItems()
            .compactMap({ $0.convertToPresentableAnswer(answer: $0) })
        allDataStorage.onNext(items.sorted { $0.timeStamp > $1.timeStamp })
    }

    func deleteItem(_ item: AnswerModel) {
        localStorage.deleteItem(item: item)
    }
}
