//
//  LeftViewController.swift
//  SnapchatMenu
//
//  Created by 王亮 on 2022/6/29.
//

import Foundation
import UIKit

class LeftViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named: "left")
//        let imageView = UIImageView(image: UIImage(named: "left"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .yellow
        
        imageView.contentMode = .scaleToFill
        
        
        self.view.addSubview(imageView)
//        self.view.backgroundColor = .red
    }
}
