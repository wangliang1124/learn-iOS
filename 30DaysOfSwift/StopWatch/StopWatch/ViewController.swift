//
//  ViewController.swift
//  StopWatch
//
//  Created by 王亮 on 2022/6/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        self.view = UI()
        
//        let label = UILabel()
//        label.text = "Test"
//        label.backgroundColor = .red
//        label.textColor = .black
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        let topConstraint = label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
//        let leadingConstraint = label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
//        let trailingConstraint = label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//
//
//        view.addSubview(label)
//
//        topConstraint.isActive = true
//        leadingConstraint.isActive = true
//        trailingConstraint.isActive = true
//
//
//        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150)
//        let firstView = UIView(frame: firstFrame)
//        firstView.backgroundColor = UIColor.blue
//        view.addSubview(firstView)
//
//        let secondFrame = CGRect(x: 100, y: 100, width: 50, height: 50)
//        let secondView = UIView(frame: secondFrame)
//        secondView.backgroundColor = UIColor.green
//        view.addSubview(secondView)
    }
}

