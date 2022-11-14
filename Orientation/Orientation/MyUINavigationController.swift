//
//  MyUINavigationController.swift
//  Orientation
//
//  Created by 王亮 on 2022/11/9.
//

import UIKit

class MyUINavigationController: UINavigationController {
    var orientationMask: UIInterfaceOrientationMask = .portrait
    
    override var shouldAutorotate: Bool {
        return self.topViewController?.shouldAutorotate ?? true;
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return orientationMask
        return self.topViewController?.supportedInterfaceOrientations ?? .portrait;
    }
}
