//
//  DocumentInfoViewController.swift
//  EmojiArt
//
//  Created by 王亮 on 2020/1/31.
//  Copyright © 2020 王亮. All rights reserved.
//

import UIKit

class DocumentInfoViewController: UIViewController {
    var document: EmojiArtDocument? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private let shorDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    private func updateUI() {
        if sizeLabel != nil, createdLabel != nil, thumbnailAspectRatio != nil,
            let url = document?.fileURL,
            let attributes = try? FileManager.default.attributesOfItem(atPath: url.path) {
            
            sizeLabel.text = "\(attributes[.size] ?? 0) bytes"
            if let created = attributes[.creationDate] as? Date {
                createdLabel.text = shorDateFormatter.string(from: created)
            }
            if thumbnailImageView != nil, let thumbnail = document?.thumbnail {
                thumbnailImageView.image = thumbnail
                thumbnailImageView.removeConstraint(thumbnailAspectRatio)
                thumbnailAspectRatio = NSLayoutConstraint(
                    item: thumbnailImageView,
                    attribute: .width,
                    relatedBy: .equal,
                    toItem: thumbnailImageView,
                    attribute: .height,
                    multiplier: thumbnail.size.width / thumbnail.size.height,
                    constant: 0
                )
                thumbnailImageView.addConstraint(thumbnailAspectRatio)
            }
            if presentationController is UIPopoverPresentationController {
                thumbnailImageView?.isHidden = true
                returnToDocumentButton?.isHidden = true
                view.backgroundColor = .clear
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = topLevelView?.sizeThatFits(UIView.layoutFittingCompressedSize) {
            preferredContentSize = CGSize(width: fittedSize.width + 30, height: fittedSize.height + 30)
        }
    }
    
    @IBAction func done(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true)
    }
    

    @IBOutlet weak var returnToDocumentButton: UIButton!
    
    @IBOutlet weak var topLevelView: UIStackView!
    
    @IBOutlet weak var thumbnailAspectRatio: NSLayoutConstraint!
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var sizeLabel: UILabel!
    
    @IBOutlet weak var createdLabel: UILabel!
}
