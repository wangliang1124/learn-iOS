//
//  ViewController.swift
//  ImageScroller
//
//  Created by 王亮 on 2022/7/23.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .blue
        return scrollView
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "steve"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
       
        return imageView
    }()
    
    var topContraint: NSLayoutConstraint!
    var bottomContraint: NSLayoutConstraint!
    var leadingContraint: NSLayoutConstraint!
    var trailingContraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        view.frame = UIScreen.main.bounds
//        scrollView.frame = UIScreen.main.bounds
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
         NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        

        topContraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        bottomContraint = imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        leadingContraint = imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        trailingContraint = imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        
        topContraint.isActive = true
        bottomContraint.isActive = true
        leadingContraint.isActive = true
        trailingContraint.isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        
        let minScale = min(widthScale, heightScale)
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
        print("minScale:\(minScale)")
    }
    
    // UIScollViewDelegate
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func updateConstraintsForSize(_ size: CGSize){
        let marginVertical = max(0, (size.height - imageView.frame.height) / 2)
        let marginHorizontal =  max(0, (size.width - imageView.frame.width) / 2)
        
        topContraint.constant = marginVertical
        bottomContraint.constant = marginVertical
        leadingContraint.constant = marginHorizontal
        trailingContraint.constant = marginHorizontal
        
        view.layoutIfNeeded()
    }
}

