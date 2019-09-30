//
//  NetworkManager.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

typealias CompletionHandler = (Answer?, Error?) -> Void
protocol DataManagerProtocol {
    
    func request(completion: @escaping CompletionHandler)
}

class NetworkManager: DataManagerProtocol {
    func request(completion: @escaping CompletionHandler) {
        let session = URLSession(configuration: .default)
    
        guard let url = URL(string: Link.url + Link.question) else {
            completion(nil, .badURL)
            return
        }

        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, .api(error: error))
            }
    
            guard let data = data,
                let json = try? JSONDecoder().decode(Answer.self, from: data) else {
                    completion(nil, .incorrectModel)
                    return
            }

            completion(json, nil)
        }
        task.resume()
    }
}
