//
//  MyView.swift
//  Test
//
//  Created by 王亮 on 2021/1/30.
//

import UIKit

class MyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .orange
            if #available(iOS 11.0, *) {
                self.frame = safeAreaLayoutGuide.layoutFrame
            }
    }
}
