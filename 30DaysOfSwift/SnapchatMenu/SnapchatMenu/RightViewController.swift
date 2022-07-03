//
//  RightViewController.swift
//  SnapchatMenu
//
//  Created by 王亮 on 2022/6/29.
//

import Foundation
import UIKit

class RightViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: UIImage(named: "right"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        self.view.addSubview(imageView)
    }
}
