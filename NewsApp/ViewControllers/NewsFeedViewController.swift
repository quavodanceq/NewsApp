//
//  ViewController.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 23.08.2023.
//

import UIKit
import SnapKit

class NewsFeedViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var news = [News]()
    
    convenience init(category: NewsCategory) {
        self.init()
        FetchManager.shared.fetchCategory(category: category) { news in
            guard let news = news else { return }
            self.news = news
            self.tableView.reloadData()
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        FetchManager.shared.fetch { news in
            
            guard let news = news else { return }
            self.news = news
            self.tableView.reloadData()
            self.tableView.snp.updateConstraints { make in
                make.height.equalTo(self.tableView.contentSize.height)
            }
        }
        
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
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white
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
        
        let categoriesViewController = CategoryViewController()
        self.navigationController?.pushViewController(categoriesViewController, animated: true)
    }
    
    @objc private func searchButtonTapped() {
        
        let seachViewController = SearchViewController()
        self.navigationController?.pushViewController(seachViewController, animated: true)
    }
    
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
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
}
