//
//  Concentration.swift
//  Concentration
//
//  Created by 王亮 on 2020/1/20.
//  Copyright © 2020 王亮. All rights reserved.
//

import Foundation

struct Concentration {
    var cards = [Card]()
    
    init(numberOfPairsOfCards:Int) {
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
        // TODO shuffle
        
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return  cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
            //            let faceUpCardIndices = cards.indices.filter({cards[$0].isFaceUp})
            //            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            //            var foundIndex: Int?
            //            for index in cards.indices {
            //                if cards[index].isFaceUp {
            //                    if foundIndex == nil {
            //                        foundIndex = index
            //                    } else {
            //                        return nil
            //                    }
            //                }
            //            }
            //            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // if match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                //                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // no cards or 2 cards
                //                for flipDownIndex in cards.indices {
                //                    cards[flipDownIndex].isFaceUp = false
                //                }
                //                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        } else{
            
        }
    }
    
    
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
