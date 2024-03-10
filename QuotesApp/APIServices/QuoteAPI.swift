//
//  ManagerAPI.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 04.03.2024.
//

import Foundation

struct Quote: Codable {
    let quote: String
    let author: String
}

class QuotesService {
    func fetchQuotes(category: String, completion: @escaping ([Quote]?, Error?) -> Void) {
        let urlString = "https://api.api-ninjas.com/v1/quotes?category=\(category)"
        
        guard let encodedUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedUrlString) else {
            completion(nil, NSError(domain: "URLCreationError", code: -1, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("/uvauKUnexqBJoUUmKv4pg==sBsiGYbNuMaFSZhG", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                completion(quotes, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
