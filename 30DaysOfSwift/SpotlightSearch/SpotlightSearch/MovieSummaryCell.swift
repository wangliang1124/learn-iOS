//
//  MovieSummaryCell.swift
//  SpotlightSearch
//
//  Created by 王亮 on 2022/8/15.
//

import UIKit

class MovieSummaryCell: UITableViewCell {
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var movieTitle: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movieDescription: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    var rating: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        
        let stackView = UIStackView(arrangedSubviews: [movieImageView])
        stackView.axis = .horizontal
 
        stackView.spacing = 10
        
        let rightStackView = UIStackView(arrangedSubviews: [movieTitle, movieDescription])
        rightStackView.axis = .vertical
        rightStackView.distribution = .equalSpacing
       
 
        stackView.addArrangedSubview(rightStackView)
        self.contentView.addSubview(stackView)
        

        stackView.fillToSuperView()
        
        NSLayoutConstraint.activate([
            movieImageView.widthAnchor.constraint(equalToConstant: 90)
//            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//            movieImageView.topAnchor.constraint(equalTo: self.topAnchor),
//            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            movieImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func fillToSuperView() {
        guard let superview = self.superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            self.topAnchor.constraint(equalTo: superview.topAnchor),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
}
