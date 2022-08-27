//
//  MenuViewController.swift
//  TumblrMenu
//
//  Created by 王亮 on 2022/7/31.
//

import UIKit

class MenuViewController: BaseViewController {
    let transitionManager = MenuTransitionManager()
    
    
    var textButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Text"), for: .normal)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
     var photoButton: UIButton = {
         let btn = UIButton()
         btn.setImage(UIImage(named: "Photo"), for: .normal)
         
         btn.translatesAutoresizingMaskIntoConstraints = false
         return btn
     }()
     var photoLabel: UILabel = {
         let label = UILabel()
         label.text = "Photo"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     var quoteButton: UIButton = {
         let btn = UIButton()
         btn.setImage(UIImage(named: "Quote"), for: .normal)
         
         btn.translatesAutoresizingMaskIntoConstraints = false
         return btn
     }()
     var quoteLabel: UILabel = {
         let label = UILabel()
         label.text = "Quote"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     var linkButton: UIButton = {
         let btn = UIButton()
         btn.setImage(UIImage(named: "Link"), for: .normal)
         
         btn.translatesAutoresizingMaskIntoConstraints = false
         return btn
     }()
     var linkLabel: UILabel = {
         let label = UILabel()
         label.text = "Link"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     var chatButton: UIButton = {
         let btn = UIButton()
         btn.setImage(UIImage(named: "Chat"), for: .normal)
         
         btn.translatesAutoresizingMaskIntoConstraints = false
         return btn
     }()
     var chatLabel: UILabel = {
         let label = UILabel()
         label.text = "Chat"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
     
     var audioButton: UIButton = {
         let btn = UIButton()
         btn.setImage(UIImage(named: "Audio"), for: .normal)
         
         btn.translatesAutoresizingMaskIntoConstraints = false
         return btn
     }()
     var audioLabel: UILabel = {
         let label = UILabel()
         label.text = "Audio"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    lazy var nevermindButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Nevermind", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.addTarget(self, action: #selector(self.dismissMenu), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.transitioningDelegate = transitionManager
        
        setupUI()
        addContraints()
    }

    func setupUI() {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        visualEffectView.addGestureRecognizer(tap)
        visualEffectView.frame = view.bounds
        visualEffectView.backgroundColor = .clear

        visualEffectView.contentView.addSubview(textButton)
        visualEffectView.contentView.addSubview(textLabel)
        visualEffectView.contentView.addSubview(photoButton)
        visualEffectView.contentView.addSubview(photoLabel)
        visualEffectView.contentView.addSubview(quoteButton)
        visualEffectView.contentView.addSubview(quoteLabel)
        visualEffectView.contentView.addSubview(linkButton)
        visualEffectView.contentView.addSubview(linkLabel)
        visualEffectView.contentView.addSubview(chatButton)
        visualEffectView.contentView.addSubview(chatLabel)
        visualEffectView.contentView.addSubview(audioButton)
        visualEffectView.contentView.addSubview(audioLabel)
        visualEffectView.contentView.addSubview(nevermindButton)
        
        view.addSubview(visualEffectView)
    }
    
    func addContraints() {
        NSLayoutConstraint.activate([
            textButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            textLabel.topAnchor.constraint(equalTo: textButton.bottomAnchor),
            textLabel.centerXAnchor.constraint(equalTo: textButton.centerXAnchor),
            
            photoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            photoLabel.topAnchor.constraint(equalTo: photoButton.bottomAnchor),
            photoLabel.centerXAnchor.constraint(equalTo: photoButton.centerXAnchor),
            
            quoteButton.topAnchor.constraint(equalTo: textButton.bottomAnchor, constant: 40),
            quoteButton.leadingAnchor.constraint(equalTo: textButton.leadingAnchor),
            quoteLabel.topAnchor.constraint(equalTo: quoteButton.bottomAnchor),
            quoteLabel.centerXAnchor.constraint(equalTo: quoteButton.centerXAnchor),
            
            linkButton.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 40),
            linkButton.trailingAnchor.constraint(equalTo: photoButton.trailingAnchor),
            linkLabel.topAnchor.constraint(equalTo: linkButton.bottomAnchor),
            linkLabel.centerXAnchor.constraint(equalTo: linkButton.centerXAnchor),
            
            chatButton.topAnchor.constraint(equalTo: quoteButton.bottomAnchor, constant: 40),
            chatButton.leadingAnchor.constraint(equalTo: quoteButton.leadingAnchor),
            chatLabel.topAnchor.constraint(equalTo: chatButton.bottomAnchor),
            chatLabel.centerXAnchor.constraint(equalTo: chatButton.centerXAnchor),
            
            audioButton.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 40),
            audioButton.trailingAnchor.constraint(equalTo: linkButton.trailingAnchor),
            audioLabel.topAnchor.constraint(equalTo: audioButton.bottomAnchor),
            audioLabel.centerXAnchor.constraint(equalTo: audioButton.centerXAnchor),

            nevermindButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nevermindButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func dismissMenu() {
        self.dismiss(animated: true)
    }
}

