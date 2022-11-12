//
//  MyUINavigationController.swift
//  Orientation
//
//  Created by 王亮 on 2022/11/9.
//

import UIKit

class MyUINavigationController: UINavigationController {
    var orientationMask: UIInterfaceOrientationMask = .portrait
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return orientationMask
    }
}
