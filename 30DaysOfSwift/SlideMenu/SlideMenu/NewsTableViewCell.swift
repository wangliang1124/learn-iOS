//
//  NewsTableViewCell.swift
//  SlideMenu
//
//  Created by 王亮 on 2022/7/29.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {
    var postImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var postTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Avenir Next", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var postAuthor: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textColor = .white
        label.layer.opacity = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var authorImageView: UIImageView = {
        let imageView =  UIImageView()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(postImageVIew)
        self.contentView.addSubview(postTitle)
        self.contentView.addSubview(postAuthor)
        self.contentView.addSubview(authorImageView)
        authorImageView.layer.cornerRadius = 20
        updateUI()
    }

    func updateUI() {
        NSLayoutConstraint.activate([
            postImageVIew.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageVIew.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            postImageVIew.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageVIew.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            authorImageView.widthAnchor.constraint(equalToConstant: 40),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            authorImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            authorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            postTitle.topAnchor.constraint(equalTo: authorImageView.topAnchor),
            postTitle.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 10),
            
            postAuthor.bottomAnchor.constraint(equalTo: authorImageView.bottomAnchor),
            postAuthor.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 10),
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
