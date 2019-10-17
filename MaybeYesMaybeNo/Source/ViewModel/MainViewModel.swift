//
//  MainViewModel.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 9/29/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class MainViewModel {
    private let answerModel: MainModel
    lazy var formmater = DateFormatter()
    init(model: MainModel) {
        self.answerModel = model
    }

    func getAnswer(completion: @escaping (PresentableAnswer?) -> Void) {
        answerModel.getAnswer { answer in
            guard let answerResult = answer else { return }
            completion(answerResult.convertToPresentableAnswer(
                text: answerResult.answer.uppercased(),
                time: self.convert(date: answerResult.timeStamp))
            )
        }
    }

    func getShakeCount(completion: @escaping (PresentableShakeCount?) -> Void) {
        answerModel.getCount { (shake) in
            guard let shake = shake else { return }
            completion(shake)
        }
    }

    func didShaken() {
        answerModel.didShaken()
    }

    private func convert(date: Date) -> String {
        formmater.timeStyle = .medium
        formmater.dateStyle = .medium
        let dateString = formmater.string(from: date)
        return dateString
    }
}
