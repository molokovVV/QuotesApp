//
//  ImageAPI.swift
//  QuotesApp
//
//  Created by Виталик Молоков on 05.03.2024.
//

import UIKit

class ImageService {
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        //Список ключевых слов для запроса
        let keywords = [
            "attitude", "beauty", "best", "birthday", "business", "car", "change",
            "communication", "computers", "cool", "courage", "dad", "dating", "death",
            "design", "dreams", "education", "environmental", "equality", "experience",
            "failure", "faith", "family", "famous", "fear", "fitness", "food",
            "forgiveness", "freedom", "friendship", "funny", "future", "god", "good",
            "government", "graduation", "great", "happiness", "health", "history",
            "home", "hope", "humor", "imagination", "inspirational", "intelligence",
            "jealousy", "knowledge", "leadership", "learning", "legal", "life", "love",
            "marriage", "medical", "men", "mom", "money", "morning", "movies", "success"
        ]
        let randomKeyword = keywords.randomElement() ?? "quotes"

        let urlString = "https://api.pexels.com/v1/search?query=\(randomKeyword)&per_page=1"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("xInlxIPVkoIGyTeL052i1XPANzV2VmOMC2FnaDcauPba3N2FGZMDl67q", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let photos = json["photos"] as? [[String: Any]],
                  let firstPhoto = photos.first,
                  let src = firstPhoto["src"] as? [String: Any],
                  let imageUrlString = src["medium"] as? String,
                  let imageUrl = URL(string: imageUrlString),
                  let imageData = try? Data(contentsOf: imageUrl),
                  let image = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
}
