//
//  ViewController.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/13.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "YouTube"
        self.navigationController?.navigationBar.backgroundColor = .orange
        navigationController?.navigationBar.barStyle = .black
        view.backgroundColor = .gray
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}

