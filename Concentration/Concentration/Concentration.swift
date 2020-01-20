//
//  Concentration.swift
//  Concentration
//
//  Created by 王亮 on 2020/1/20.
//  Copyright © 2020 王亮. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    init(numberOfPairsOfCards:Int){
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        // TODO shuffle
        
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // if match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // no cards or 2 cards
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        } else{
            
        }
    }
    
    
}
