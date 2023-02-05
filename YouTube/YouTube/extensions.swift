//
//  extensions.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/20.
//

import UIKit

extension MutableCollection where Index == Int {
    mutating func myShuffle() {
        if count < 2 { return }
        
        for i in startIndex ..< endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
}


extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}

extension UIApplication {
    var currentWindow: UIWindow? {
        // iOS 15 and 16, compatible down to iOS 13
        return UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }
        // iOS 16, compatible down to iOS 15
//        return UIApplication
//            .shared
//            .connectedScenes
//            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
//            .first
    }
}

extension NavController {
//    open override var childForStatusBarStyle: UIViewController? {
//        return visibleViewController
//    }
//
    open override var preferredStatusBarStyle: UIStatusBarStyle {
           .lightContent
       }
//

}

extension Int {
    func secondsToDateString() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let second = (self % 3600) % 60
        
        let h = String(hours)
        
        let m: String = {
            if minutes <= 9 && minutes >= 0 {
               return  "0\(minutes)"
            }
            return String(minutes)
        }()
        
        let s: String = {
            if second <= 9 && second >= 0 {
               return "0\(second)"
            }
            return String(second)
        }()
        
        var label = ""
        
        if hours == 0 {
            label = m + ":" + s
        } else {
            label = h + ":" + m + ":" + s
        }
        
        return label
    }
}
