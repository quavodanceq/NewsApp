//
//  SavedNewsPublisher.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 27.08.2023.
//

import Foundation

extension UserDefaults {
    
    @objc dynamic private(set) var observableNewsData: Data? {
                get {
                    UserDefaults.standard.data(forKey: "news")
                }
                set { UserDefaults.standard.set(newValue, forKey: "news") }
            }
    
    var news: [News]{
       get{
           guard let data = UserDefaults.standard.data(forKey: "news") else { return [] }
           return (try? JSONDecoder().decode([News].self, from: data)) ?? []
       } set{
           observableNewsData = try? JSONEncoder().encode(newValue)
       }
    }
}
