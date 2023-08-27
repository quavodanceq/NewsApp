//
//  File.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 25.08.2023.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    
    var news: News
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let titleLabel = UILabel()
    
    private let dateLabel = UILabel()
    
    private let uiImageView = UIImageView()
    
    private let descriptionLabel = UILabel()
    
    private let contentLabel = UILabel()
    
    private let saveButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .navBarBackgroundColor
        setupNavigationBar()
        setupScrollView()
        setupTitleLabel()
        setupDateLabel()
        setupImageView()
        setupDescriptionLabel()
        setupContentLabel()
        setupConstraints()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        self.news = News(title: "", link: "", description: "", content: "", pubDate: "", imageURL: "")
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience init(news: News) {
        
        self.init()
        self.news = news
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNavigationBar() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.navBarBackgroundColor
        navigationController?.navigationBar.tintColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveNews))
    }
    
    private func setupTitleLabel() {
        
        titleLabel.text = news.title
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Georgia-Italic", size: 25)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()
    }
    
    private func setupDateLabel() {
        
        dateLabel.text = news.pubDate
        dateLabel.numberOfLines = 0
        dateLabel.font = UIFont(name: "Georgia-Bold", size: 18)
        dateLabel.textColor = .white
        dateLabel.sizeToFit()
    }
    
    private func setupImageView() {
        
        guard let urlString = news.imageURL else { return }
        guard let url = URL(string: urlString) else { return }
        uiImageView.sd_setImage(with: url)
        uiImageView.sizeToFit()
    }
    
    private func setupDescriptionLabel() {
        
        descriptionLabel.text = news.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Georgia-Bold", size: 20)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
    }
    
    private func setupContentLabel() {
        
        contentLabel.text = news.content
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont(name: "Georgia-Bold", size: 20)
        contentLabel.textColor = .white
        contentLabel.sizeToFit()
    }
    
    
    private func setupScrollView() {
        
        view.addSubview(scrollView)
        
        scrollView.backgroundColor = .navBarBackgroundColor
        scrollView.isScrollEnabled = true
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(uiImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(contentLabel)
    }
    
    @objc private func saveNews() {
        
        SavedNewsManager.shared.add(news)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .plain, target: self, action: #selector(saveNews))
        
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            
            
        }
        
        contentView.snp.makeConstraints { make in
            
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.width.equalToSuperview()
            
        }
        
        titleLabel.snp.makeConstraints { make in
            
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            
        }
        
        dateLabel.snp.makeConstraints { make in
            
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        if news.imageURL != nil {
            
            uiImageView.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.bottom).offset(10)
                make.width.equalToSuperview()
                make.height.equalTo(uiImageView.snp.width)
            }
        } else {
            
            uiImageView.snp.makeConstraints { make in
                make.top.equalTo(dateLabel.snp.bottom).offset(10)
            }
        }
        
        descriptionLabel.snp.makeConstraints { make in
            
            make.top.equalTo(uiImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        contentLabel.snp.makeConstraints { make in
            
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
    }
}



