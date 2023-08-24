//
//  ViewController.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 23.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var news = [News]()
    
    override func viewWillLayoutSubviews() {
        
        
        
        tableView.snp.makeConstraints { make in
            make.height.equalTo(tableView.contentSize.height)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .navBarBackgroundColor
        setupNavigationBar()
        setupTableView()
        setupConstraints()
        FetchManager.shared.fetch { news in
            
            guard let news = news else { return }
            self.news = news
            self.tableView.reloadData()
            self.tableView.snp.updateConstraints { make in
                make.height.equalTo(self.tableView.contentSize.height)
            }
                
        }
        
    }

    private func setupNavigationBar() {
        
        let image = UIImage(named: "logo")
        let logoView = UIImageView(image: image)
        logoView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoView
        let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor.navBarBackgroundColor
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navigationItem.standardAppearance = appearance
                navigationItem.scrollEdgeAppearance = appearance
                navigationItem.compactAppearance = appearance
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet.rectangle.fill"), style: .plain, target: self, action: #selector(newsSphereButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func setupTableView() {
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "newsCell")
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc private func newsSphereButtonTapped() {
        print(123123123)
    }
    
    @objc private func searchButtonTapped() {
        print(33333333333)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
     
        return 1000
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return UITableView.automaticDimension
    }
    
    
    
}
