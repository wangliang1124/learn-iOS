//
//  Channel.swift
//  SlideoutMenu
//
//  Created by 王亮 on 2022/8/12.
//

import Foundation

class ChannelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }


}
