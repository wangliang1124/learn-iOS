//
//  ViewController.swift
//  TumblrMenu
//
//  Created by 王亮 on 2022/7/31.
//

import UIKit

class MainViewController: BaseViewController {
    let photo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "1"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let toolbar: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "toolbar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let postButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "newPost"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         
        view.backgroundColor = .darkGray
        
        view.addSubview(photo)
        view.addSubview(toolbar)
        view.addSubview(postButton)
        postButton.addTarget(self, action: #selector(post), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photo.widthAnchor.constraint(equalTo: view.widthAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            toolbar.widthAnchor.constraint(equalTo: view.widthAnchor),
            postButton.centerYAnchor.constraint(equalTo: toolbar.centerYAnchor),
            postButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc
    func post(){
        let vc = MenuViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
    }
}

