//
//  InterestCollectionViewCell.swift
//  Carousel
//
//  Created by 王亮 on 2022/7/3.
//

import Foundation
import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    var featuredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        return visualEffectView
    }()
    
    var interestTitleLabel: UILabel = {
        let titleLable = UILabel()
        titleLable.translatesAutoresizingMaskIntoConstraints = false
//        titleLable.backgroundColor = .yellow
       
        return titleLable
    }()
    
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addViews()
    }
    
    func addViews(){
        addSubview(featuredImageView)
        
        blurEffectView.contentView.addSubview(interestTitleLabel)
        addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            featuredImageView.topAnchor.constraint(equalTo: self.topAnchor),
            featuredImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            featuredImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            featuredImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            interestTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100),
            
//            featuredImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            featuredImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            featuredImageView.widthAnchor.constraint(equalToConstant: 300),
//            featuredImageView.heightAnchor.constraint(equalToConstant: 400),
            blurEffectView.heightAnchor.constraint(equalToConstant: 60),
            blurEffectView.leadingAnchor.constraint(equalTo: featuredImageView.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: featuredImageView.trailingAnchor),
//            blurEffectView.widthAnchor.constraint(equalTo: featuredImageView.widthAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: featuredImageView.bottomAnchor),
            interestTitleLabel.centerYAnchor.constraint(equalTo: blurEffectView.centerYAnchor),
            interestTitleLabel.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor, constant: 16),
        ])
    }
    
    
    func updateUI(){
        self.backgroundColor = .blue
        
        featuredImageView.image = interest.featuredImage
        interestTitleLabel.text = interest.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
