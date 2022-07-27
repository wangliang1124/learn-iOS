//
//  ViewController.swift
//  LoginAnimation
//
//  Created by 王亮 on 2022/7/25.
//

import UIKit

class WelcomeViewController: UIViewController {
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "username"
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.layer.cornerRadius = 5
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Login"
        configuration.background.backgroundColor = .green
        configuration.cornerStyle = .medium
        let btn = UIButton(configuration: configuration)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var centerAlignUsername: NSLayoutConstraint!
    var centerAlignPassword: NSLayoutConstraint!
    var loginWidthContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        centerAlignUsername = usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        centerAlignPassword = passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        loginWidthContraint = loginButton.widthAnchor.constraint(equalToConstant: 150)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            centerAlignUsername,
            usernameTextField.widthAnchor.constraint(equalToConstant: 320),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            centerAlignPassword,
            passwordTextField.widthAnchor.constraint(equalToConstant: 320),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginWidthContraint,
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        centerAlignUsername.constant -= view.bounds.width
        centerAlignPassword.constant -= view.bounds.width
        loginButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.00, options: .curveEaseOut, animations: {
            self.centerAlignUsername.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.10, options: .curveEaseOut, animations: {
            self.centerAlignPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.20, options: .curveEaseOut, animations: {
            self.loginButton.alpha = 1
            self.loginButton.addTarget(self, action: #selector(self.loginButtonDidTouch), for: .touchUpInside)
        }, completion: nil)
    }
    
    
    @objc
    func loginButtonDidTouch(_ sender: UIButton){
        let bounds = self.loginButton.bounds
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveLinear, animations: {
            
            self.loginButton.bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            self.loginButton.isEnabled = false
            
        }, completion: { finished in self.loginButton.isEnabled = true })
    }
}

