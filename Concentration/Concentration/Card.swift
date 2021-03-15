//
//  Card.swift
//  Concentration
//
//  Created by 王亮 on 2020/1/20.
//  Copyright © 2020 王亮. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    //    var hashValue:Int {
    //        return identifier
    //    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    private static var indentifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
