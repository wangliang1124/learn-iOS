//
//  Card.swift
//  Concentration
//
//  Created by 王亮 on 2020/1/20.
//  Copyright © 2020 王亮. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var indentifierFactory = 0
    
    private static func getUniqueIdentifier()->Int{
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
