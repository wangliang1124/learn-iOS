//
//  TestBViewController.swift
//  Orientation
//
//  Created by 王亮 on 2022/11/12.
//

import UIKit


class TestBViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestB"
        
        view.backgroundColor = .lightGray
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
}
