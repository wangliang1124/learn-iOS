//
//  ViewController.swift
//  Concentration
//
//  Created by 王亮 on 2020/1/19.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var flipCount = 0 {
        didSet {
              flipCountLabel.text = "Flips:\(flipCount)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    let emojiChoices = ["🎃","👻","🎃","👻"]

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
//    @IBAction func touchSecondCard(_ sender: UIButton) {
//         flipCount += 1
////        flipCountLabel.text = "Flips:\(flipCount)"
//         flipCard(withEmoji: "🎃", on: sender)
//    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        print("flipCard:\(emoji)")
        if button.currentTitle == emoji{
             button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor=#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        } else{
            
             button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
       
    }
}

