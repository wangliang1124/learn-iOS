//
//  ImageViewController.swift
//  Cassini
//
//  Created by 王亮 on 2020/1/27.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    var imageURL: URL? {
        didSet {
            image = nil
            if view.window != nil {
                print("didSet")
                fetchImage()
            }
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageView = UIImageView()
    
    private func fetchImage() {
        print("fetch")
        if let url = imageURL {
            let task = URLSession.shared.dataTask(with: url, completionHandler: {
                (data: Data?, _: URLResponse?, error: Error?) in
                if let imageData = data {
                    DispatchQueue.main.sync {
                        self.image = UIImage(data: imageData)
                    }
                }
            })
            
            task.resume()
//            let urlContents = try? Data(contentsOf: url)
//            if let imageData = urlContents {
//                self.image = UIImage(data: imageData)
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        if imageURL == nil {
            // URL(string: "https://images.unsplash.com/photo-1657299170936-0531a116c87c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
            imageURL =  DemoURLs.NASA["Earth"] //DemoURLs.stanford
        }
    }
}
