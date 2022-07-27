//
//  SplashViewController.swift
//  LoginAnimation
//
//  Created by 王亮 on 2022/7/25.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var signupButton: UIButton!

 
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signupButton.layer.cornerRadius = 5
        loginButton.layer.cornerRadius = 5
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc
    func login() {
        let vc = WelcomeViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
}
