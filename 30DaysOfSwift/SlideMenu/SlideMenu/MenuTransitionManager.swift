//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by 王亮 on 2022/7/31.
//

import Foundation
import UIKit

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}

class MenuTransitionManager: NSObject {
    var duration = 0.5
    var isPresenting = true
    var delegate: MenuTransitionManagerDelegate?

    var snapshot: UIView? {
        didSet {
            if let delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer(target: delegate, action: #selector(delegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
}

extension MenuTransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromView = transitionContext.view(forKey: .from), let toView = transitionContext.view(forKey: .to) else {
//            return
//        }
//
        let fromViewController = transitionContext.viewController(forKey: .from)
        let toViewController = transitionContext.viewController(forKey: .to)

        guard let fromView = fromViewController?.view,
              let toView = toViewController?.view else {
            return
        }

        let container = transitionContext.containerView

        if isPresenting {
            fromView.transform = CGAffineTransform(translationX: 0, y: 0)
            toView.transform = CGAffineTransform(translationX: 0, y: -50)
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }

        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            if self.isPresenting {
                self.snapshot?.transform = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
                toView.transform = .identity

            } else {
                self.snapshot?.transform = .identity
            }
        }, completion: { _ in
            transitionContext.completeTransition(true)
            fromViewController?.endAppearanceTransition()
            toViewController?.endAppearanceTransition()
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        })
    }
}

extension MenuTransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
}
