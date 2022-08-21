//
//  ViewController.swift
//  SnapchatMenu
//
//  Created by 王亮 on 2022/6/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let leftViewController = LeftViewController()
        let centerViewController  = CameraViewController()
        let rightViewController = RightViewController()
        
        leftViewController.view.frame = CGRect(x: 0, y: 0, width: screenWidth - 200, height: screenHeight)
        centerViewController.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        rightViewController.view.frame = CGRect(x: 2 * screenWidth, y: 0, width: screenWidth, height: screenHeight)

        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = view.bounds
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(leftViewController.view)
        scrollView.addSubview(centerViewController.view)
        scrollView.addSubview(rightViewController.view)
        scrollView.contentSize = CGSize(width: 3 * screenWidth, height: screenHeight)
        
        view.addSubview(scrollView)
        
//        view.addConstraintsForSubviewWithSameSize(scrollView)
        view.backgroundColor = .gray
        
       
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//
//        let imagePicker = UIImagePickerController()
//        // If the device has a camera, take a picture; otherwise,
//        // just pick from photo library
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            imagePicker.sourceType = .camera
//        } else {
//            imagePicker.sourceType = .photoLibrary
//        }
//
//        present(imagePicker, animated: true, completion: nil)
//    }
    
//    override func loadView() {
//        self.view = UIScrollView()
//    }
//
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//let LAYOUT_OPT_NONE = NSLayoutConstraint.FormatOptions(rawValue: 0)
//
//extension UIView {
//    func addConstraintsForSubviewWithSameSize(_ view: UIView, useSafeArea: Bool = false) {
//        if useSafeArea {
//            NSLayoutConstraint.activate([
//                view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//                view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
//                view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//                view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
//            ])
//        } else {
//            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: LAYOUT_OPT_NONE, metrics: nil, views: ["view":view]))
//            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: LAYOUT_OPT_NONE, metrics: nil, views: ["view":view]))
//        }
//    }
//}
