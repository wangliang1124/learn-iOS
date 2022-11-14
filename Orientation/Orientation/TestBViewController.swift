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
        
        
        let button = UIButton()
        button.setTitle("Open C", for: .normal)
        
        
        button.addTarget(self, action: #selector(openTestC), for: .touchUpInside)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIDevice.current.setOrientation(orientationMask: self.supportedInterfaceOrientations)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return .landscapeLeft
//    }
    
    @objc
    func openTestC(){
        let vc = TestCViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
