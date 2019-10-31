//
//  SettingsViewModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/1/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class SettingsViewModel {

    // MARK: - Public Properties

    let allDataStorage = BehaviorSubject<[PresentableAnswer]>(value: [])
    let deletingEvent = PublishSubject<PresentableAnswer>()
    let updateAnswers = PublishSubject<[PresentableAnswer]>()
    let addAnswer = PublishSubject<PresentableAnswer>()
    // MARK: - Private Properties

    private let settingsModel: SettingsModel
    private let disposedBag = DisposeBag()

    // MARK: - Init

    init(model: SettingsModel) {
        self.settingsModel = model
        setupBindigs()
    }

    // MARK: - Private Function

    private func setupBindigs() {
        settingsModel.allDataStorage.bind(onNext: { [weak self] presentable in
            guard let self = self else { return }
            let items = presentable.map { $0 }
            self.allDataStorage.onNext(items)
        }).disposed(by: disposedBag)

        deletingEvent.asObservable().bind(onNext: { [weak self] answerModel in
            guard let self = self else { return }
            self.settingsModel.deletingEvent.onNext(answerModel.convertToAnswerModel())
        }).disposed(by: disposedBag)

        addAnswer.bind(onNext: { presentableAnswer in
            self.settingsModel.addAnswer.onNext(presentableAnswer.convertToAnswerModel())
        }).disposed(by: disposedBag)
    }

    // MARK: - Public Function

    func reloadDataBaseStorage() {
        settingsModel.getlocalStorageItems()
    }

    func removeItem(_ dataBase: IndexPath) {
        guard var items = try? allDataStorage.value() else { return }
        deletingEvent.onNext(items[dataBase.row])
        items.remove(at: dataBase.row)
        allDataStorage.onNext(items)
    }
}
