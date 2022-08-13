//
//  ScaleViewController.swift
//  BasicAnimation
//
//  Created by 王亮 on 2022/8/13.
//

import Foundation
import UIKit

class ScaleViewController: UIViewController {
    lazy var imageView = UIImageView(image: UIImage(named: "emoji alpha me"))
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.imageView.alpha = 1
        }, completion: nil)
    }
}
