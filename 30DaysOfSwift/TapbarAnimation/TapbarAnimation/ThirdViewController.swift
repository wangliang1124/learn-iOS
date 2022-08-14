//
//  ThirdViewController.swift
//  TapbarAnimation
//
//  Created by 王亮 on 2022/8/14.
//

import Foundation
import UIKit

class ThirdViewController: UIViewController {
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
        
        resetViewTransform()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.profileImageView.alpha = 1
            self.profileImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        resetViewTransform()
    }
    
    func resetViewTransform() {
        self.profileImageView.alpha = 0
        self.profileImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
}
