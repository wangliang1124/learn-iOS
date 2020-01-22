//
//  ViewController.swift
//  PlayingCard
//
//  Created by 王亮 on 2020/1/22.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var deck = PlayingCardDeck()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for _ in 1...10 {
            if let card = deck.draw(){
                print("\(card)")
            }
        }
    }


}

