//
//  NewsCategoryViewController.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 26.08.2023.
//

import Foundation
import UIKit
import SnapKit

class CategoryViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private let categories: [NewsCategory] = [.business,.entertainment,.environment,.food,.health,.politics,.science,.sports,.technology,.tourism,.world]
    
    override func viewDidLoad() {
        
        view?.backgroundColor = .navBarBackgroundColor
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .navBarBackgroundColor
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 50, left: 10, bottom: 50, right: 10)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        categories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = categories[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Georgia-Bold", size: 20)
        cell.backgroundColor = .navBarBackgroundColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        view.frame.size.height / 15
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let feedViewController = NewsFeedViewController(category: categories[indexPath.row])
        navigationController?.pushViewController(feedViewController, animated: true)
    }
    
    
}
