//
//  ViewController.swift
//  LimitCharactors
//
//  Created by 王亮 on 2022/8/2.
//

import UIKit

class ViewController: UIViewController {
    var tweetTextView: UITextView = {
        let textView = UITextView()
        textView.text = ""
        textView.textColor = .lightGray
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.backgroundColor = .clear
        textView.layer.cornerRadius = 10
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var bottomUIView: UIView = {
        let bottomView = UIView()
        
        let cameraBtn = UIButton()
        cameraBtn.setImage(UIImage(named: "Camera"), for: .normal)
        cameraBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        let searchBtn = UIButton()
        searchBtn.setImage(UIImage(named: "Search"), for: .normal)
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        bottomView.addSubview(cameraBtn)
        bottomView.addSubview(searchBtn)
        bottomView.addSubview(characterCountLabel)
        //        let cameraContraint = NSLayoutConstraint(item:cameraBtn , attribute: .centerY, relatedBy: .equal, toItem: bottomView, attribute: .centerY, multiplier: 1, constant: 0)
        //
        //        bottomView.addConstraint(cameraContraint)
        
        NSLayoutConstraint.activate([
            cameraBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
            cameraBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            searchBtn.leadingAnchor.constraint(equalTo: cameraBtn.trailingAnchor, constant: 10),
            searchBtn.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
            characterCountLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10),
            characterCountLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
        ])
        
        bottomView.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 1)
        //        bottomView.layer.cornerRadius = 4
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        return bottomView
    }()
    
    lazy var avatarImageView: UIImageView = {
      
        let imageView = UIImageView(image: UIImage(named: "avatar"))
//        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var characterCountLabel: UILabel = {
        let label = UILabel()
        label.text = "140"
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupUI() {
        
        view.addSubview(avatarImageView)
        view.addSubview(tweetTextView)
        view.addSubview(bottomUIView)
        view.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            tweetTextView.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            tweetTextView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            tweetTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tweetTextView.heightAnchor.constraint(equalToConstant: 266),
            
            bottomUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomUIView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.masksToBounds = true
    }
    
    @objc func keyboardWillShow(_ noti: Notification) {
        guard let userInfo = noti.userInfo else {
            return
        }
        
        let keyboardBounds = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = keyboardBounds.size.height - view.safeAreaInsets.bottom
        
        let animations = {
            self.bottomUIView.transform = CGAffineTransform(translationX: 0, y: -deltaY)
        }
        
        if duration > 0 {
            UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: animations, completion: nil)
        } else {
            animations()
        }
    }
    
    @objc func keyboardWillHide(_ noti: Notification) {
        guard let userInfo = noti.userInfo else {
            return
        }
        
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations = {
            self.bottomUIView.transform = .identity
        }
        
        if duration > 0 {
            UIView.animate(withDuration: duration, delay: 0, options: [.beginFromCurrentState, .curveLinear], animations: animations, completion: nil)
        } else {
            animations()
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputTextLength = text.count - range.length + textView.text.count
        
        if inputTextLength > 140 {
            return false
        }
        
        characterCountLabel.text = "\(140 - inputTextLength)"
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.19, alpha: 1)
    }
}
