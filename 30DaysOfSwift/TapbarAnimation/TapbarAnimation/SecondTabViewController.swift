//
//  SecondTabViewController.swift
//  TapbarAnimation
//
//  Created by 王亮 on 2022/8/14.
//

import Foundation
import UIKit

class SecondTabViewController: UIViewController {
    var exploreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Explore")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(exploreImageView)
        NSLayoutConstraint.activate([
            exploreImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            exploreImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        resetViewTransform()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.exploreImageView.alpha = 1
            self.exploreImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        resetViewTransform()
    }
    
    func resetViewTransform() {
        self.exploreImageView.alpha = 0
        self.exploreImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
}
