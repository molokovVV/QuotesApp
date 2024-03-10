//
//  JokeAPI.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 05.03.2024.
//

import Foundation

class JokesService {
    func fetchJoke(completion: @escaping (String?, Error?) -> Void) {
        let urlString = "https://api.api-ninjas.com/v1/jokes"
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("/uvauKUnexqBJoUUmKv4pg==sBsiGYbNuMaFSZhG", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]],
                   let firstJoke = jsonResponse.first,
                   let joke = firstJoke["joke"] as? String {
                    completion(joke, nil)
                } else {
                    completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No joke found"]))
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

