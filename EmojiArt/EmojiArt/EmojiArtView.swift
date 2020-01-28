//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by 王亮 on 2020/1/28.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit

class EmojiArtView: UIView {
    
    var backgroundImage: UIImage? { didSet { setNeedsDisplay() } }
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
    
    
}
