//
//  FetchManager.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 24.08.2023.
//

import Foundation
import Alamofire

class FetchManager {
    
    private init() {}
    
    static let shared = FetchManager()
    
    func fetch(completion: @escaping([News]?) -> Void) {
        
        AF.request("https://newsdata.io/api/1/news?apikey=pub_281754adee3f2331df99714eeeca254ffceeb&q=pegasus&language=en").response { response in
            print(response)
            let decoder = JSONDecoder()
            let data = try? decoder.decode(Response.self, from: response.data!)
            if let news = data?.results {
                completion(data?.results)
            }
            completion(nil)
        }
        
    }
}
