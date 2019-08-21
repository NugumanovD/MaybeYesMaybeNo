//
//  NetworkManager.swift
//  MaybeYesMaybeNo
//
//  Created by Nugumanov Dmitriy on 8/21/19.
//  Copyright © 2019 Nugumanov Dmitriy. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func fetchAnswer(complation: @escaping (Answer?, Error?) -> Void) {
        
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: Link.url + Link.question) else {
            complation(nil, .badURL)
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complation(nil, .api(error: error))
                print(error.localizedDescription)
                return
            }
            
            guard let data = data,
                let json = try? JSONDecoder().decode(Answer.self, from: data) else {
                    complation(nil, .incorrectModel)
                    return
            }
            complation(json, nil)
        }
        task.resume()
    }
    
}
