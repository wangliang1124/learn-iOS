//
//  RotationViewController.swift
//  BasicAnimation
//
//  Created by 王亮 on 2022/8/13.
//

import Foundation
import UIKit

class RotationViewController: UIViewController {
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.text = "💩"
        label.font = UIFont.systemFont(ofSize: 100)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
//    lazy var imageView = UIImageView(image: UIImage(named: "emoji alpha me"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(emojiLabel)
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.spin()
    }
    
    func spin() {
//        UIView.animate(withDuration: 0.5) {
//            self.emojiLabel.transform = CGAffineTransform(rotationAngle: .pi)
//        }

        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
//            CGAffineTransform(rotationAngle: 2 * .pi)
            self.emojiLabel.transform =  self.emojiLabel.transform.rotated(by: .pi)
        }, completion: { finished in
            self.spin()
        })
    }
}
