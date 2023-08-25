//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 25.08.2023.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView = UITableView()
    
    private var news = [News]()
    
    override func viewDidLoad() {
        
        view.backgroundColor = .navBarBackgroundColor
        setupSearchController()
        setupTableView()
        setupConstraints()
    }
    
    private func setupSearchController() {
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController?.searchBar.isHidden = false
        navigationItem.hidesSearchBarWhenScrolling = false 
        searchController.searchBar.placeholder = "Search news"
        searchController.searchBar.searchTextField.attributedPlaceholder =  NSAttributedString.init(string: "Search news", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.textColor = .white
        if let leftView = searchController.searchBar.searchTextField.leftView as? UIImageView {
            leftView.image = UIImage(named: "magnifyingglass")?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor.white
            }
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: "newsCell")
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

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate  {
    
    func updateSearchResults(for searchController: UISearchController) {
        FetchManager.shared.fetchWithSearch(searchText: searchController.searchBar.text ?? "") { fetchedNews in
            print(searchController.searchBar.text)
            if fetchedNews != nil {
                print("not nil")
                self.news = fetchedNews!
                print(self.news)
                self.tableView.reloadData()
            }
           
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? NewsCell {
            cell.news = news[indexPath.row]
            cell.setup()
            return cell
        }
        
        return UITableViewCell()
    }
}
