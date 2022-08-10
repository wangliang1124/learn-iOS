//
//  AnimationCollectionViewCell.swift
//  CollectionViewAnimation
//
//  Created by 王亮 on 2022/8/9.
//

import Foundation
import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "1"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Back-icon"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.zPosition = 1
        btn.addTarget(self, action: #selector(backButtonDidTouch), for: .touchUpInside)
        return btn
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = "Hedge fund billionaire Bill Ackman was humbled in 2015. His Pershing Square Capital Management had a terrible year, posting a -19.3% gross return."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var backButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI(){
        addSubview(backBtn)
        addSubview(imageView)
        addSubview(textView)

        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        NSLayoutConstraint.activate([
            backBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 44),
            backBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: 140),
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
    
//    func updateUI(){
//
//    }
//
    func prepareCell(viewModel: AnimationCellModel) {
        imageView.image = UIImage(named: viewModel.imagePath)
        textView.isScrollEnabled = false
        backBtn.isHidden = true
    }
    
    func handleCellSelected() {
        textView.isScrollEnabled = false
        backBtn.isHidden = false
        self.superview?.bringSubviewToFront(self)
    }
    
    @objc func backButtonDidTouch() {
        backButtonTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
