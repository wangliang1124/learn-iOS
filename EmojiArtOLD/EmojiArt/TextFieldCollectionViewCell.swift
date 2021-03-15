//
//  TextFieldCollectionViewCell.swift
//  EmojiArt
//
//  Created by 王亮 on 2020/1/29.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    

    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    
    var resignationHandler: (() -> Void)?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        resignationHandler?()
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        return true
//    }
}
