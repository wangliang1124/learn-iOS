//
//  TestCViewController.swift
//  Orientation
//
//  Created by 王亮 on 2022/11/12.
//

import UIKit


class TestCViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "TestC"
        
        view.backgroundColor = .lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIDevice.current.setOrientation(orientationMask: self.supportedInterfaceOrientations)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
