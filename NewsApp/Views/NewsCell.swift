//
//  NewsCell.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 24.08.2023.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    var news: News?
    
    private let image = UIImageView()
    
    private let titleLabel = UILabel()
    
    private let descriptionLabel = UILabel()
    
    private let pubDateLabel = UILabel()
    
    private func setupImage() {
        addSubview(image)
        guard let urlString = news?.imageURL else { return }
        guard let url = URL(string: urlString) else { return }
        
        image.sd_setImage(with: url)
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(image.snp.width).multipliedBy(0.6)
        }
        
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = news?.title
        titleLabel.numberOfLines = 0
        
        titleLabel.font = UIFont(name: "Georgia-Italic", size: 25)
        titleLabel.textColor = .white
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.font = UIFont(name: "Georgia-Bold", size: 20)
        descriptionLabel.text = news?.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
    }
    
    private func setupDateLabel() {
        addSubview(pubDateLabel)
        pubDateLabel.text = news?.pubDate
        pubDateLabel.font = UIFont(name: "Georgia", size: 17)
        pubDateLabel.textColor = .white
    }
    
    
    func setup() {
        setupImage()
        setupTitleLabel()
        setupDescriptionLabel()
        setupDateLabel()
        backgroundColor = .navBarBackgroundColor
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        pubDateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
       
    }
    
}
