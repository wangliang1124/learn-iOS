//
//  ViewController.swift
//  CustomFont
//
//  Created by 王亮 on 2020/1/15.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text="Hello, world"
        label.textAlignment = NSTextAlignment.center
        self.view.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 30)
        
        let btn = UIButton(type:.custom)
        btn.setTitle("change font family", for: UIControl.State.normal)
        btn.addTarget(self, action:#selector(changeFontFamily), for: UIControl.Event.touchUpInside)
        btn.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        self.view.addSubview(btn)
        
        btn.layer.borderColor = UIColor.blue.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
//        btn.
        
        printAllSupportedFontNames()
    }
    
    @objc func changeFontFamily(){
        label.font = UIFont(name:"Savoye LET", size: 32)
    }
    
    func printAllSupportedFontNames() {
        let familyNames = UIFont.familyNames
        for familyName  in familyNames {
            print("=======\(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("-------\(fontName)")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
