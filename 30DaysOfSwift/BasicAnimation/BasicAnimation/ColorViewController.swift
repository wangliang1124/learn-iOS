//
//  ColorViewController.swift
//  BasicAnimation
//
//  Created by 王亮 on 2022/8/13.
//

import Foundation
import UIKit

class ColorViewController: UIViewController {
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "@allllllllen"
        label.font = UIFont(name: "Avenir Next", size: 40)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.addSubview(self.textLabel)
      
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    override func loadView() {
        self.view = bgView
    }
     
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
            self.view.backgroundColor = .black
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.8, options: .curveEaseOut, animations: {
            self.textLabel.textColor = UIColor(red:0.959, green:0.937, blue:0.109, alpha:1)
        }, completion: nil)
    }
}
