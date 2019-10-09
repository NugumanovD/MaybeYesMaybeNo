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
    func didShaken()
}

class KeychainManager: ShakesCounting {

    let keychain = KeychainSwift()
    init() {
        _ = keychain.set("0", forKey: Key.countShake)
    }

    func getShakesCount(completion: @escaping ShakeMotionHandler) {
        guard let unwrappedCount = keychain.get(Key.countShake) else { return }
        let shakeModel = PresentableShakeCount(shakeCount: unwrappedCount)
        completion(shakeModel)
    }

    func didShaken() {
        let count = keychain.get(Key.countShake)
        guard let countr = count else { return }
        let addedCount = 1 + (Int(countr) ?? 0)
        keychain.set("\(addedCount)", forKey: Key.countShake)
    }
}
