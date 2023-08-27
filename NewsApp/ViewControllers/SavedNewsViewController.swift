//
//  SavedNewsViewController.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 27.08.2023.
//

import Foundation
import UIKit
import Combine

class SavedNewsViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var news = [News]()
    
    var cancellable = [AnyCancellable]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
    }
    
    override func viewDidLoad() {
        print(news)
        
        super.viewDidLoad()
        view.backgroundColor = .navBarBackgroundColor
        setupNavigationBar()
        setupTableView()
        setupConstraints()
        setupPublisher()
    }
    
    private func setupPublisher() {
        
        UserDefaults.standard.publisher(for: \.observableNewsData)
            .map{ data -> [News] in
                guard let data = data else { return [] }
                return (try? JSONDecoder().decode([News].self, from: data)) ?? []
            }.sink { news in
                
                self.news = news
                
            }.store(in: &cancellable)
    }
    
    private func setupNavigationBar() {
        
        let image = UIImage(named: "logo")
        let logoView = UIImageView(image: image)
        logoView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoView
    }
    
    private func setupTableView() {
        
        tableView.register(SavedNewsCell.self, forCellReuseIdentifier: "newsCell")
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

extension SavedNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as? SavedNewsCell {
            cell.news = news[indexPath.row]
            cell.setup()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = news[indexPath.row]
        let viewControllerToPresent = NewsViewController(news: news)
        navigationController?.pushViewController(viewControllerToPresent, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 1000
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            SavedNewsManager.shared.remove(news[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}
