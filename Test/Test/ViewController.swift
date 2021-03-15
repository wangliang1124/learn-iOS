//
//  ViewController.swift
//  Test
//
//  Created by 王亮 on 2021/1/30.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(view.safeAreaInsets)
        let insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
       
        print(insets)
        let myView = MyView()
        view.addSubview(myView)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(view.safeAreaInsets)
    }
}

