//
//  WebService.swift
//  NYTStories
//
//  Created by Oğuzhan Varsak on 20.05.2022.
//

import UIKit
import Foundation

class WebService {
    
    let utilityQueue = DispatchQueue.global(qos: .utility)

    func getArticles(url: URL, completion: @escaping (ArticleList?) -> Void) {
        
        let session = URLSession.init(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                
                print(error.localizedDescription)
            } else {
                
                if let data = data {
                    if let articleList = self.parseJSON(data: data) {
                        completion(articleList.results)
                    }
                }
            }
        }
        
        task.resume()
        
    }
    
    func parseJSON(data: Data) -> MainModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodedData = try decoder.decode(MainModel.self, from: data)
            
            return decodedData
            
        } catch {
            
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadImage(for url: String, completion: @escaping (UIImage?) -> Void) {
        
            utilityQueue.async {
                
                let url = URL(string: url)

                guard let data = try? Data(contentsOf: url!) else { return }
                let image = UIImage(data: data)

                completion(image)
            }
        }
}
