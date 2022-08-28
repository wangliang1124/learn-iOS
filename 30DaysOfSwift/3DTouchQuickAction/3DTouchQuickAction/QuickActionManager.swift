//
//  QuickActionManager.swift
//  3DTouchQuickAction
//
//  Created by 王亮 on 2022/8/11.
//

import Foundation
import UIKit

enum ShortcutIdentifier: String {
    case First
    case Second
    case Third
    
    init?(fullType: String) {
        guard let last = fullType.components(separatedBy: ".").last else {
            return nil
        }
        
        self.init(rawValue: last)
    }
    
    var type: String {
        return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
    }
}

class QuickActionManager {
    @discardableResult
    static func handleShortcutItem(_ shortcutIem: UIApplicationShortcutItem?) -> Bool {
        guard let shortcutIem = shortcutIem else {
            return false
        }

        guard let _ = ShortcutIdentifier(fullType: shortcutIem.type) else {
            return false
        }
        
//        guard let shortcutType = shortcutIem.type as String? else {
//            return false
//        }
        
        let shortcutType = shortcutIem.type
        var handled = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc: UIViewController?
        
        switch shortcutType {
            case ShortcutIdentifier.First.type:
                vc = storyboard.instantiateViewController(withIdentifier: "RunVC") as? RunViewController
                handled = true
            case ShortcutIdentifier.Second.type:
                vc = storyboard.instantiateViewController(withIdentifier: "ScanVC") as? ScanViewController
                handled = true
            case ShortcutIdentifier.Third.type:
                vc = storyboard.instantiateViewController(withIdentifier: "WifiVC") as? SwitchWifiViewController
                handled = true
            default:
                vc = UIViewController()
        }
        
        var presentedVC: UIViewController? = UIApplication.currentWindow?.rootViewController //  UIApplication.shared.windows.first?.rootViewController //
        
        while presentedVC?.presentedViewController != nil {
            presentedVC = presentedVC?.presentedViewController
        }
//        presentedVC?.isMember(of: vc.classForCoder) == false
        if let vc = vc,  presentedVC?.isKind(of: type(of: vc)) == false {
            presentedVC?.present(vc, animated: true)
        }
        
        return handled
    }
}


extension UIApplication {
    
    static var currentWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
//            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
//
    
//    static var currentWindow: UIWindow? {
//          if #available(iOS 13, *) {
//              return UIApplication.shared.connectedScenes
//                  .compactMap {$0 as? UIWindowScene }
//                  .flatMap { $0.windows }
//                  .first { $0.isKeyWindow }
//          } else {
//              return UIApplication.shared.keyWindow
//          }
//      }
    
}
