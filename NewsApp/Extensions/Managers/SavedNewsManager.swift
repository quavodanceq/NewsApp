//
//  SavedNewsManager.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 27.08.2023.
//

import Foundation

class SavedNewsManager {
    
    private init() {}
    
    static let shared = SavedNewsManager()
    
    let userDefaults = UserDefaults.standard
    
    func add(_ news: News) {
        
        userDefaults.news.append(news)
    }
    
    func remove(_ news: News) {
        
        let savedNews = userDefaults.news
        guard let index = savedNews.firstIndex(of: news) else { return }
        userDefaults.news.remove(at: index)
    }
    
}
