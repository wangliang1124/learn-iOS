//
//  PositionViewController.swift
//  BasicAnimation
//
//  Created by 王亮 on 2022/8/13.
//

import Foundation
import UIKit

class PositionViewController: UIViewController {
    var yellowSquareView: UIView = {
        let view = UIView()
//        view.frame.size = CGSize(width: 100, height: 100)
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var blueSquareView: UIView = {
        let view = UIView()
//        view.frame.size = CGSize(width: 100, height: 100)
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var mouseView: UIView = {
        let view = UIView()
//        view.frame.size = CGSize(width: 200, height: 20)
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        self.view = UIView()
        view.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        view.addSubview(yellowSquareView)
        view.addSubview(blueSquareView)
        view.addSubview(mouseView)
        
        NSLayoutConstraint.activate([
            yellowSquareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            yellowSquareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            yellowSquareView.widthAnchor.constraint(equalToConstant: 100),
            yellowSquareView.heightAnchor.constraint(equalToConstant: 100),
            blueSquareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            blueSquareView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            blueSquareView.widthAnchor.constraint(equalToConstant: 100),
            blueSquareView.heightAnchor.constraint(equalToConstant: 100),
            mouseView.widthAnchor.constraint(equalToConstant: 200),
            mouseView.heightAnchor.constraint(equalToConstant: 20),
            mouseView.topAnchor.constraint(equalTo: yellowSquareView.bottomAnchor, constant: 30),
            mouseView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.8, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            self.yellowSquareView.center.x = self.view.bounds.width - self.yellowSquareView.center.x
            self.yellowSquareView.center.y = self.yellowSquareView.center.y + 30

            self.blueSquareView.center.x = self.view.bounds.width -  self.blueSquareView.center.x
            self.blueSquareView.center.y = self.blueSquareView.center.y + 30
            
        }, completion: nil)
        
        UIView.animate(withDuration: 2.8, delay: 0.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.setMouseHeight(180)
            
            self.mouseView.center.y = self.view.frame.height - self.mouseView.center.y
            
        }, completion: nil)
        
    }
    
    func setMouseHeight(_ height: CGFloat) {
        var frame = self.mouseView.frame
        frame.size.height = height
        
        self.mouseView.frame = frame
    }
}
