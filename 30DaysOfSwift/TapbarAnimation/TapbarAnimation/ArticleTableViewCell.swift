//
//  ArticleTableViewCell.swift
//  TapbarAnimation
//
//  Created by 王亮 on 2022/8/14.
//

import Foundation
import UIKit

struct article {
    let avatarImage: String
    let sharedName: String
    let actionType: String
    let articleTitle: String
    let articleCoverImage: String
    let articleSouce: String
    let articleTime: String
}

class ArticleTableViewCell: UITableViewCell {
    var avatarImage: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var sharedNameLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var actionTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var articleCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .red
        return imageView
    }()

    var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
//        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var articleSouceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var articelCreatedAtLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view1 = UIView()
        view1.backgroundColor = .white
        view1.translatesAutoresizingMaskIntoConstraints = false
        
        let view2 = UIView()
        view2.backgroundColor = .white
        view2.translatesAutoresizingMaskIntoConstraints = false
        
        let border = UIView()
        border.backgroundColor = .blue
        border.translatesAutoresizingMaskIntoConstraints = false
        
        view1.addSubview(avatarImage)
        view1.addSubview(sharedNameLabel)
        view1.addSubview(actionTypeLabel)
        
        view2.addSubview(articleCoverImage)
        view2.addSubview(articleTitleLabel)
        view2.addSubview(articleSouceLabel)
        view2.addSubview(articelCreatedAtLabel)
        
        self.contentView.addSubview(view1)
        self.contentView.addSubview(border)
        self.contentView.addSubview(view2)
        self.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        
        NSLayoutConstraint.activate([
            view1.widthAnchor.constraint(equalTo: self.widthAnchor),
            view1.heightAnchor.constraint(equalToConstant: 50),
            avatarImage.topAnchor.constraint(equalTo: view1.topAnchor, constant: 10),
            avatarImage.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 10),
            avatarImage.widthAnchor.constraint(equalToConstant: 30),
            avatarImage.heightAnchor.constraint(equalToConstant: 30),
            sharedNameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 10),
            sharedNameLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            actionTypeLabel.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -10),
//            actionTypeLabel.centerYAnchor.constraint(equalTo: avatarImage.centerYAnchor),
            
            avatarImage.centerYAnchor.constraint(equalTo: view1.centerYAnchor),
            sharedNameLabel.centerYAnchor.constraint(equalTo: view1.centerYAnchor),
            actionTypeLabel.centerYAnchor.constraint(equalTo: view1.centerYAnchor),
            
            border.topAnchor.constraint(equalTo: view1.bottomAnchor),
            border.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            border.heightAnchor.constraint(equalToConstant: 1),
         
//            view2.widthAnchor.constraint(equalTo: self.widthAnchor),
            articleCoverImage.widthAnchor.constraint(equalToConstant: 120),
            articleCoverImage.heightAnchor.constraint(equalToConstant: 100),
            articleCoverImage.leadingAnchor.constraint(equalTo: view2.leadingAnchor),
            articleCoverImage.heightAnchor.constraint(equalTo: view2.heightAnchor),
            articleTitleLabel.leadingAnchor.constraint(equalTo: articleCoverImage.trailingAnchor, constant: 20),
            articleTitleLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -20),
            articleSouceLabel.leadingAnchor.constraint(equalTo: articleCoverImage.trailingAnchor, constant: 20),
            articleSouceLabel.bottomAnchor.constraint(equalTo: articleCoverImage.bottomAnchor),
            articelCreatedAtLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor),
            articelCreatedAtLabel.bottomAnchor.constraint(equalTo: view2.bottomAnchor),
            
            view1.topAnchor.constraint(equalTo: self.topAnchor),
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor),
            view2.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
