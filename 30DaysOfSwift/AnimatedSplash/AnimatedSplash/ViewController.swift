//
//  ViewController.swift
//  AnimatedSplash
//
//  Created by 王亮 on 2022/7/29.
//

import UIKit

class ViewController: UIViewController {
//    let imageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "screen"))
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()

    @IBOutlet var imageView: UIImageView!

    var mask: CALayer = CALayer()
    var maskView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        mask.contents = UIImage(named: "twitter")?.cgImage
        mask.contentsGravity = .resizeAspect
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)

//        imageView.setNeedsLayout()
//        imageView.layoutIfNeeded()

        mask.position = view.center // CGPoint(x: imageView.frame.size.width / 2, y: imageView.frame.size.height / 2)

        imageView.layer.mask = mask

        view.addSubview(imageView)

        maskView = UIView(frame: view.frame)
        maskView.backgroundColor = .white
        view.addSubview(maskView)

        if let scene = UIApplication.shared.connectedScenes.first,
           let window = (scene.delegate as? SceneDelegate)?.window {
            window.backgroundColor = UIColor(red: 29 / 255.0, green: 161 / 255.0, blue: 242 / 255.0, alpha: 1)
        }

        animateMask()
    }

    func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")

        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 1
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut), CAMediaTimingFunction(name: .easeInEaseOut)]

        do {
            keyFrameAnimation.fillMode = .forwards
            keyFrameAnimation.isRemovedOnCompletion = false
        }

        let initalBounds = NSValue(cgRect: mask.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 85, height: 85))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1600, height: 1300))

        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]

        mask.add(keyFrameAnimation, forKey: "bounds")

        let logoOpacityAnimation = CABasicAnimation(keyPath: "opacity")
        logoOpacityAnimation.beginTime = CACurrentMediaTime() + 1
        logoOpacityAnimation.duration = 1
        logoOpacityAnimation.fromValue = 1
        logoOpacityAnimation.toValue = 0
        logoOpacityAnimation.delegate = self
        maskView.layer.add(logoOpacityAnimation, forKey: "opacityAnimation")
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        imageView.layer.mask = nil
        maskView.removeFromSuperview()
    }
}
