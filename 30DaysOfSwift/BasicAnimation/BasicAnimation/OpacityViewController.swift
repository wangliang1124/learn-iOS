//
//  OpacityViewController.swift
//  BasicAnimation
//
//  Created by 王亮 on 2022/8/13.
//

import Foundation
import UIKit

class OpacityViewController: UIViewController {
    lazy var imageView = UIImageView(image: UIImage(named: "colored ASCII art"))
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor),
        ])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 2, animations: {
            self.imageView.alpha = 0.1
        })
    }
}
