//
//  ViewController.swift
//  Concentration
//
//  Created by 王亮 on 2020/1/19.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit

class ConcentrationViewController: VCLLoggingViewController {
    override var vclLoggingName: String {
        return "Game"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
    
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet {
            updateFlipCountLabel()
        }
    }
    
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel(){
        let attributes:[NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor :  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attribrtedString = NSAttributedString(string: "Flips:\(flipCount)", attributes: attributes)
        //            flipCountLabel.text = "Flips:\(flipCount)"
        flipCountLabel.attributedText = attribrtedString
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            //            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    private func updateViewFromModel(){
        if cardButtons == nil {
            return
        }
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0) : #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            }
        }
    }
    
    var theme:String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    //    private var emojiChoices = ["🍭","👻","🎃","😈","👽"]
    private var emojiChoices = "🍭👻🎃😈👽"
    
    private var emoji = [Card: String]()
    
    private func emoji(for card:Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
    }
    
}

extension Int {
    var arc4random : Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
