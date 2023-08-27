//
//  SavedNewsCell.swift
//  NewsApp
//
//  Created by Куат Оралбеков on 27.08.2023.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

class SavedNewsCell: UITableViewCell {
    
    var news: News?
    
    private let image = UIImageView()
    
    private let titleLabel = UILabel()
    
    private func setupImage() {
        addSubview(image)
        guard let urlString = news?.imageURL else { return }
        guard let url = URL(string: urlString) else { return }
        
        image.sd_setImage(with: url)
        image.snp.makeConstraints { make in
            
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(image.snp.height)
            make.centerY.equalToSuperview()
        }
        
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = news?.title
        titleLabel.numberOfLines = 0
        
        titleLabel.font = UIFont(name: "Georgia-Italic", size: 18)
        titleLabel.textColor = .white
    }
    
    
    func setup() {
        setupImage()
        setupTitleLabel()
        backgroundColor = .navBarBackgroundColor
        
        titleLabel.snp.makeConstraints { make in
            
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(image.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
    }
    
}
