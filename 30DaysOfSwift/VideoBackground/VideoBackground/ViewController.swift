//
//  ViewController.swift
//  VideoBackground
//
//  Created by 王亮 on 2022/7/24.
//

import UIKit

class ViewController: VideoSplashViewController {
//    var loginButton: UIButton!
//    var signupButton: UIButton!
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupVideoBackground()
        
        let imageView =  UIImageView(image: UIImage(named: "login-secondary-logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
//        red="0.31703859569999998" green="0.67122757430000002" blue="0.19592839479999999"
        let color = UIColor(red: 0.32, green: 0.67, blue: 0.2, alpha: 1)
        
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = color
        loginButton.layer.cornerRadius = 4
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let signupButton = UIButton()
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.setTitleColor(color, for: .normal)
        signupButton.backgroundColor = .white
        signupButton.layer.cornerRadius = 4
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signupButton.widthAnchor.constraint(equalToConstant: 300),
            signupButton.heightAnchor.constraint(equalToConstant: 45),
            signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 300),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupVideoBackground() {
        if let path = Bundle.main.path(forResource: "moments", ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            
            contentURL = url
            alwaysRepeat = true
        }
    }
}

