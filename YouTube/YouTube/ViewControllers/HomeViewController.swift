//
//  HomeViewController.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/13.
//

import UIKit

class HomeViewController: UITableViewController {
    var videos = [Video]()
    var lastContentOffset: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.title = "YouTube"
        setupUI()
        fetchData()
        
        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func fetchData() {
        Video.fetchVideos { [weak self] response in
            guard let weakSelf = self else { return }
                
            weakSelf.videos = response
            weakSelf.videos.myShuffle()
            weakSelf.tableView.reloadData()
        }
    }
    
    func setupUI() {
        self.tableView.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 30, right: 0)
        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 300
    }
    
    // delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
    
}

fileprivate class VideoCell: UITableViewCell {
    var video: Video! {
        didSet {
            self.videoThumbnail.image = video.thumbnail
            self.durationLabel.text = video.duration.secondsToDateString()
            self.durationLabel.layer.borderColor = UIColor.lightGray.cgColor
            self.durationLabel.layer.borderWidth = 1.0
            self.channelPic.image = video.channel.image
            self.videoTitle.text = video.title
            self.videoDesc.text = "\(video.channel.name) · \(video.views)"
        }
    }
    
    var videoThumbnail: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var durationLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.textColor = .white
        label.backgroundColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    var channelPic: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var videoTitle: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var videoDesc: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(videoThumbnail)
        self.contentView.addSubview(durationLabel)
        self.contentView.addSubview(channelPic)
        self.contentView.addSubview(videoTitle)
        self.contentView.addSubview(videoDesc)
        self.contentView.backgroundColor = .white
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            videoThumbnail.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoThumbnail.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            videoThumbnail.heightAnchor.constraint(equalTo: videoThumbnail.widthAnchor, multiplier: 9 / 16),
            
            durationLabel.trailingAnchor.constraint(equalTo: videoThumbnail.trailingAnchor, constant: -5),
            durationLabel.bottomAnchor.constraint(equalTo: videoThumbnail.bottomAnchor, constant: -5),
            
            channelPic.widthAnchor.constraint(equalToConstant: 48),
            channelPic.heightAnchor.constraint(equalToConstant: 48),
            channelPic.topAnchor.constraint(equalTo: videoThumbnail.bottomAnchor, constant: 16),
            channelPic.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            videoTitle.topAnchor.constraint(equalTo: channelPic.topAnchor),
            videoTitle.leadingAnchor.constraint(equalTo: channelPic.trailingAnchor, constant: 16),
            
            videoDesc.leadingAnchor.constraint(equalTo: videoTitle.leadingAnchor),
            videoDesc.bottomAnchor.constraint(equalTo: channelPic.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

