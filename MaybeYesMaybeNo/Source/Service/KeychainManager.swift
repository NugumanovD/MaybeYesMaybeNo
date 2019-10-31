//
//  KeychainManager.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 10/9/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import KeychainSwift

protocol ShakesCounting {
    typealias ShakeMotionHandler = (PresentableShakeCount?) -> Void
    func getShakesCount(completion: @escaping ShakeMotionHandler)
    func getShakeCount() -> PresentableShakeCount
    func didShake()
}

class KeychainManager: ShakesCounting {

    private let keychain = KeychainSwift()
    var currentCount = ""
    init() {
        currentCount = keychain.get(Key.countShake) ?? "0"
    }

    func getShakesCount(completion: @escaping ShakeMotionHandler) {
        guard let unwrappedCount = keychain.get(Key.countShake) else { return }
        let shakeModel = PresentableShakeCount(shakeCount: unwrappedCount)
        completion(shakeModel)
    }

    func getShakeCount() -> PresentableShakeCount {
        let count = keychain.get(Key.countShake)
        let shakeModel = PresentableShakeCount(shakeCount: count ?? "")
        return shakeModel
    }

    func didShake() {
        let count = keychain.get(Key.countShake)
        guard let curerrentForAdded = count else { return }
        let addedCount = 1 + (Int(curerrentForAdded) ?? 0)
        keychain.set("\(addedCount)", forKey: Key.countShake)
    }
}
