//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by 王亮 on 2022/6/28.
//
import UIKit

struct Video {
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
    var videoScreenshot: UIImageView = {
        let imageView =  UIImageView()
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var videoTitle: UILabel = {
        let label =  UILabel()
        label.text = "videoTitle"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videoSource: UILabel = {
        let label =  UILabel()
        label.text = "videoSource"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var playVideoButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "playBtn"), for: .normal)
//        btn.imageView?.contentMode = .scaleToFill
//        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.addTarget(self, action: #selector(play), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(videoScreenshot)
        self.contentView.addSubview(videoTitle)
        self.contentView.addSubview(videoSource)
        self.contentView.addSubview(playVideoButton)
        
        NSLayoutConstraint.activate([
            videoScreenshot.topAnchor.constraint(equalTo: self.topAnchor),
            videoScreenshot.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            videoScreenshot.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            videoScreenshot.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            videoTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            videoTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
            videoSource.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            videoSource.topAnchor.constraint(equalTo: videoTitle.bottomAnchor, constant: 5),
            
           
            playVideoButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playVideoButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    init(videoScreenshot: UIImageView, videoTitle: UILabel, videoSource: UILabel) {
    //        self.videoScreenshot = videoScreenshot
    //        self.videoTitle = videoTitle
    //        self.videoSource = videoSource
    //        super.init(style: .default, reuseIdentifier: "VideoCell")
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
