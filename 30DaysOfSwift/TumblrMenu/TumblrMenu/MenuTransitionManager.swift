//
//  MenuTransitionManager.swift
//  TumblrMenu
//
//  Created by 王亮 on 2022/7/31.
//

import Foundation
import UIKit

class MenuTransitionManager: NSObject {
    private var isPresenting = false
}

extension MenuTransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
}

extension MenuTransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
              let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let container = transitionContext.containerView
        let screens: (from: UIViewController, to: UIViewController) = (fromViewController, toViewController)
        
        guard let menuViewController = (!self.isPresenting ? screens.from : screens.to) as? MenuViewController else {
            return
        }
        
        let bottomViewController = !self.isPresenting ? screens.to : screens.from
        
        guard let menuView = menuViewController.view else {
            return
        }
        guard let bottomView = bottomViewController.view else {
            return
        }
        
        if self.isPresenting {
            self.offStageMenuController(menuViewController)
        }
        
        container.addSubview(bottomView)
        container.addSubview(menuView)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting {
                self.onStageMenuController(menuViewController)
            } else {
                self.offStageMenuController(menuViewController)
            }
        }, completion:  { finished in
            transitionContext.completeTransition(true)
            UIApplication.currentWindow?.addSubview(screens.to.view)
        })
    }
    
    func offStageMenuController(_ menuViewController: MenuViewController) {
        if !self.isPresenting {
            menuViewController.view.alpha = 0
        }
        
        let topRowOffset: CGFloat = 300
        let middleRowOffset: CGFloat = 150
        let bottomRowOffset: CGFloat = 50
        
        menuViewController.textButton.transform = self.offstage(-topRowOffset)
        menuViewController.textLabel.transform = self.offstage(-topRowOffset)
        
        menuViewController.quoteButton.transform = self.offstage(-middleRowOffset)
        menuViewController.quoteLabel.transform = self.offstage(-middleRowOffset)
        
        menuViewController.chatButton.transform = self.offstage(-bottomRowOffset)
        menuViewController.chatLabel.transform = self.offstage(-bottomRowOffset)
        
        menuViewController.photoButton.transform = self.offstage(topRowOffset)
        menuViewController.photoLabel.transform = self.offstage(topRowOffset)
        
        menuViewController.linkButton.transform = self.offstage(middleRowOffset)
        menuViewController.linkLabel.transform = self.offstage(middleRowOffset)
        
        menuViewController.audioButton.transform = self.offstage(bottomRowOffset)
        menuViewController.audioLabel.transform = self.offstage(bottomRowOffset)
    }
    
    func offstage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func onStageMenuController(_ menuViewController: MenuViewController) {
        menuViewController.view.alpha = 1
        
        menuViewController.textButton.transform = .identity
        menuViewController.textLabel.transform = .identity
        menuViewController.quoteButton.transform = .identity
        menuViewController.quoteLabel.transform = .identity
        menuViewController.chatButton.transform = .identity
        menuViewController.chatLabel.transform = .identity
        menuViewController.photoButton.transform = .identity
        menuViewController.photoLabel.transform = .identity
        menuViewController.linkButton.transform = .identity
        menuViewController.linkLabel.transform = .identity
        menuViewController.audioButton.transform = .identity
        menuViewController.audioLabel.transform = .identity
    }
}


extension UIApplication {
    static var currentWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
                .compactMap {$0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
