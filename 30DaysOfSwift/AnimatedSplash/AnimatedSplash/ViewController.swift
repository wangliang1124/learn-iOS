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
    
    @IBOutlet weak var imageView: UIImageView!
    
    var mask: CALayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mask.contents = UIImage(named: "twitter")?.cgImage
        mask.contentsGravity = .resizeAspect
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 81)
        mask.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        imageView.setNeedsLayout()
        imageView.layoutIfNeeded()
        
        mask.position = CGPoint(x: imageView.frame.size.width / 2, y: imageView.frame.size.height / 2)
        
        imageView.layer.mask = mask
        imageView.frame = view.bounds
        
        view.addSubview(imageView)
        

        animateMask()
    }
    
    func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime = CACurrentMediaTime() + 0.2
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut), CAMediaTimingFunction(name: .easeInEaseOut)]
        
//        do {
//            keyFrameAnimation.fillMode = .forwards
//            keyFrameAnimation.isRemovedOnCompletion = false
//        }
        
        let initalBounds = NSValue(cgRect: mask.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 90 * 0.9, height: 73 * 0.9))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1600, height: 1300))
        
        keyFrameAnimation.values = [initalBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.3, 1]
        
        mask.add(keyFrameAnimation, forKey: "bounds")
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.imageView.layer.mask = nil
    }
}
