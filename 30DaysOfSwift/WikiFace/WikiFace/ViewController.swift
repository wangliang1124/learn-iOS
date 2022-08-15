//
//  ViewController.swift
//  WikiFace
//
//  Created by 王亮 on 2022/8/15.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter the name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    var faceImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self

        view.addSubview(nameTextField)
        view.addSubview(faceImageView)

        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            faceImageView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            faceImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            faceImageView.widthAnchor.constraint(equalToConstant: 300),
            faceImageView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if let name = textField.text {
            do {
                try WikiFace.faceForPerson(name, size: CGSize(width: 300, height: 300), completion: {
                    (image: UIImage?, imageFound: Bool) in

                    if imageFound == false {
                        return
                    }

                    DispatchQueue.main.async {
                        self.faceImageView.image = image

                        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                            self.faceImageView.layer.shadowOpacity = 0.4
                            self.faceImageView.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
                            self.faceImageView.layer.shadowRadius = 15.0
                            self.faceImageView.layer.shadowColor = UIColor.black.cgColor
                        }, completion: nil)

                         // TODO: improve
                        WikiFace.centerImageViewOnFace(self.faceImageView)
                    }

                })
            } catch WikiFace.WikiFaceError.CouldNotDownloadImage {
                print("Could not access wikipedia for downloading an image")
            } catch {
                print(error)
            }
        }

        return true
    }
}
