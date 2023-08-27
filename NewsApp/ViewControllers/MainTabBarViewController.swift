//
//  MainTabBarViewController.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 27.08.2023.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {
    
    private let newsFeedViewController = NewsFeedViewController()
    
    private let savedNewsViewController = SavedNewsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newsFeedVC = UINavigationController(rootViewController: newsFeedViewController)
        newsFeedVC.tabBarItem.title = "News"
        newsFeedVC.tabBarItem.image = UIImage(systemName: "newspaper")
        
        let savedNewsVC = UINavigationController(rootViewController: savedNewsViewController)
        savedNewsVC.tabBarItem.title = "Saved"
        savedNewsVC.tabBarItem.image = UIImage(systemName: "person.crop.rectangle")
      
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        setViewControllers([newsFeedVC,
                            savedNewsVC,], animated: false)
        
        tabBar.backgroundColor = .navBarBackgroundColor
    }
}
