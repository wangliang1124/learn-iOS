//
//  SignupProfileViewController.swift
//  iMessageImagePicker
//
//  Created by 王亮 on 2022/8/14.
//

import UIKit
import Photos

class SignupProfileViewController: UIViewController {
    var userProfileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "defaultAvatar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var profileImage: UIImage = {
        let image = UIImage()
        
        return image
    }()
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        
        let bgImageView = UIImageView(image: UIImage(named: "moon"))
        bgImageView.frame = view.bounds
        
//        userProfileImageView.frame.size = CGSize(width: 100, height: 100)
//        userProfileImageView.layer.cornerRadius = userProfileImageView.bounds.width / 2
//        userProfileImageView.layer.masksToBounds = true
        
        view.addSubview(bgImageView)
        view.addSubview(userProfileImageView)
        view.addSubview(usernameTextField)
        
        setupConstraints()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pickProfileImage))
        userProfileImageView.addGestureRecognizer(tapGestureRecognizer)
        userProfileImageView.isUserInteractionEnabled = true
        
        usernameTextField.becomeFirstResponder()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 100),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 100),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 40),
        ])
    }
    
    @objc func pickProfileImage(_ tap: UITapGestureRecognizer) {
        let authorization = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        if authorization == .notDetermined {
            PHPhotoLibrary.requestAuthorization { _ in
                DispatchQueue.main.async {
                    self.pickProfileImage(tap)
                }
            }
        }
        
        if authorization == .authorized {
            let controller = ImagePickerSheetController(mediaType: .imageAndVideo)
            
            let action = ImagePickerAction(title: "Take Photo or Video", secondaryTitle: "Use this one", handler: { action in
                self.takePhoto()
            }, secondaryHandler: { (action, numberOfPhotos) in
                print("Send \(controller.selectedAssets)")
                
                if let image = controller.selectedAssets.first?.image {
                    self.userProfileImageView.image = image
                    self.userProfileImageView.layer.cornerRadius = self.userProfileImageView.frame.size.width / 2
                    self.userProfileImageView.layer.masksToBounds = true
                }
         
            })
            
            let cancelAction = ImagePickerAction(title: "Cancel", style: .cancel, handler: { _ in
                print("Cancelled")
            })
            
            controller.addAction(action)
            controller.addAction(cancelAction)
            
            self.present(controller, animated: true)
        }
    }
    
    func takePhoto() {
        print(#function)
    }
}

extension PHAsset {

    var image : UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}
