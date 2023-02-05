//
//  PlayerView.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/22.
//

import UIKit
import AVFoundation

protocol PlayerVCDelegate {
    func didMinimize()
    func didMaximize()
    func swipeToMinimize(translation: CGFloat, toState: StateOfVC)
    func didEndedSwipe(toState: StateOfVC)
    func setPreferStatusBarHidden(_ preferHidden: Bool)
}

enum StateOfVC {
    case minimized
    case fullScreen
    case hidden
}

enum Direction {
    case up
    case left
    case none
}

class PlayerView: UIView, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    var video: Video! {
        didSet {
            let videoPlayer = AVPlayer(url: video.videoLink)
            let playerLayer = AVPlayerLayer(player: videoPlayer)
            playerLayer.frame = playerView.frame
            playerLayer.videoGravity = .resizeAspectFill
            playerView.layer.addSublayer(playerLayer)
            
            self.videoPlayer = videoPlayer
            self.tableView.reloadData()
        }
    }
    
    var delegate: PlayerVCDelegate?
    var state = StateOfVC.hidden
    var direction = Direction.none
    var videoPlayer: AVPlayer!
    
    lazy var playerView = {
        let  view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var minimizeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "minimize"), for: .normal)
        btn.addTarget(self, action: #selector(minimize), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var player: UIView = {
        let view = UIView()
        view.layer.anchorPoint.applying(CGAffineTransform(translationX: -0.5, y: -0.5))
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.play))
        view.addGestureRecognizer(gesture)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fetchVideo()
        setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 90
        self.tableView.register(SuggestionVideoCell.self, forCellReuseIdentifier: "SuggestionVideoCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(play), name: NSNotification.Name(rawValue: "open"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchVideo() {
        Video.fetchVideo { [weak self] video in
            guard let weakSelf = self else {
                return
            }
            weakSelf.video = video
            weakSelf.videoPlayer.play()
            weakSelf.tableView.reloadData()
        }
    }
    
    func setupUI() {
        self.backgroundColor = .blue
         
        let guesture = UIPanGestureRecognizer(target: self, action: #selector(minimizeGesture))
        self.addGestureRecognizer(guesture)
        self.isUserInteractionEnabled = true
        
        self.addSubview(playerView)
        self.addSubview(minimizeButton)
        self.addSubview(tableView)

        NSLayoutConstraint.activate([
            minimizeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            minimizeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: self.topAnchor),
            playerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9 / 16)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    @objc func play() {
        self.videoPlayer.play()
        self.delegate?.didMaximize()
    }
    
    @objc func minimize() {
        self.delegate?.didMinimize()
    }
    
    @objc func minimizeGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            let velocity = sender.velocity(in: nil)
            if abs(velocity.x) < abs(velocity.y) {
                self.direction = .up
            } else {
                self.direction = .left
            }
        }
        
        var finalState = StateOfVC.fullScreen
        switch self.state {
        case .fullScreen:
            let factor = abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height
            self.changeValues(scaleFactor: factor)
            self.delegate?.swipeToMinimize(translation: factor, toState: .minimized)
            finalState = .minimized
        case .minimized:
            if self.direction == .left {
                finalState = .hidden
                let factor = sender.translation(in: nil).x
                self.delegate?.swipeToMinimize(translation: factor, toState: .hidden)
            } else {
                finalState = .fullScreen
                let factor = 1 - abs(sender.translation(in: nil).y) / UIScreen.main.bounds.height
                self.changeValues(scaleFactor: factor)
                self.delegate?.swipeToMinimize(translation: factor, toState: .fullScreen)
            }
        default: break
        }
        
        if sender.state == .ended {
            self.state = finalState
//            self.
            self.delegate?.didEndedSwipe(toState: self.state)
            if self.state == .hidden {
                self.videoPlayer.pause()
            }
        }
    }
    
    func changeValues(scaleFactor: CGFloat) {
        
    }
    
    // MARK: - delegation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.video?.suggestedVideos.count {
            return count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return MyCustomHeader(video: self.video)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionVideoCell", for: indexPath) as! SuggestionVideoCell
        cell.video = video.suggestedVideos[indexPath.row]
        return cell
        
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! HeaderCell
//            return cell
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SuggestionVideoCell
//            
//            return cell
//        }
    }
    
}


private class MyCustomHeader: UITableViewHeaderFooterView {
 
      init(video: Video) {
          super.init(reuseIdentifier: "")
        
        var title: UILabel = UILabel()
        title.text = video.title
        title.translatesAutoresizingMaskIntoConstraints = false
        
        var viewCount: UILabel = UILabel()
        viewCount.text = "\(video.views) views"
        viewCount.translatesAutoresizingMaskIntoConstraints = false
        
          var likesWrapper = {
              let view = UIView()
              
              let thumbUp = UIImageView()
              thumbUp.image = UIImage(named: "thumbUp")
              thumbUp.translatesAutoresizingMaskIntoConstraints = false
              
              var likes: UILabel = UILabel()
              likes.text = "\(video.likes)"
              likes.translatesAutoresizingMaskIntoConstraints = false
              
              let thumbDown = UIImageView()
              thumbDown.image = UIImage(named: "thumbDown")
              thumbDown.translatesAutoresizingMaskIntoConstraints = false
              
                var disLikes: UILabel = UILabel()
                disLikes.text = "\(video.disLikes)"
                disLikes.translatesAutoresizingMaskIntoConstraints = false
                
              view.addSubview(thumbUp)
              view.addSubview(likes)
              view.addSubview(thumbDown)
              view.addSubview(disLikes)
              
              NSLayoutConstraint.activate([

                thumbUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                thumbUp.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                likes.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                likes.leadingAnchor.constraint(equalTo: thumbUp.trailingAnchor, constant: 8),
                
                thumbDown.leadingAnchor.constraint(equalTo: likes.trailingAnchor, constant: 20),
                thumbDown.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                disLikes.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                disLikes.leadingAnchor.constraint(equalTo: thumbDown.trailingAnchor, constant: 8),
              ])
               
              return view
          }()

          likesWrapper.translatesAutoresizingMaskIntoConstraints = false
          
          let channelView: UIView = {
              var channelTitle: UILabel = UILabel()
              channelTitle.text = video.channel.name
              channelTitle.translatesAutoresizingMaskIntoConstraints = false
              
              var chanelPic: UIImageView = UIImageView()
              chanelPic.image = video.channel.image
              chanelPic.translatesAutoresizingMaskIntoConstraints = false
              
              var chanelSubscribers: UILabel = UILabel()
              chanelSubscribers.text = "\(video.channel.subscribers) subscribers"
              chanelSubscribers.translatesAutoresizingMaskIntoConstraints = false
              
              let view = UIView()
              
              view.addSubview(chanelPic)
              view.addSubview(channelTitle)
              view.addSubview(chanelSubscribers)
              view.backgroundColor = .red
              
              NSLayoutConstraint.activate([
                chanelPic.heightAnchor.constraint(equalToConstant: 50),
                chanelPic.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                
                channelTitle.topAnchor.constraint(equalTo: chanelPic.topAnchor),
                channelTitle.leadingAnchor.constraint(equalTo: chanelPic.trailingAnchor, constant: 20),
                
                chanelSubscribers.leadingAnchor.constraint(equalTo: channelTitle.leadingAnchor),
                chanelSubscribers.bottomAnchor.constraint(equalTo: chanelPic.bottomAnchor)
              ])
              
              return view
          }()
          
          channelView.translatesAutoresizingMaskIntoConstraints = false
 
          
          contentView.addSubview(title)
          contentView.addSubview(viewCount)
          contentView.addSubview(likesWrapper)
          contentView.addSubview(channelView)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            viewCount.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            viewCount.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            likesWrapper.topAnchor.constraint(equalTo: viewCount.bottomAnchor, constant: 20),
            likesWrapper.widthAnchor.constraint(equalTo: contentView.widthAnchor),
           
            channelView.topAnchor.constraint(equalTo: likesWrapper.bottomAnchor, constant: 20),
            channelView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            channelView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class SuggestionVideoCell: UITableViewCell {
    var video: SuggestedVideo! {
        didSet {
            thumbnail.image = video.thumbnail
            title.text = video.title
            name.text = video.channelName
        }
    }
    
    var thumbnail: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(thumbnail)
        self.contentView.addSubview(title)
        self.contentView.addSubview(name)
        self.contentMode = .scaleToFill
    
        
        NSLayoutConstraint.activate([
            thumbnail.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            thumbnail.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnail.widthAnchor.constraint(equalToConstant: 124),
            thumbnail.heightAnchor.constraint(equalToConstant: 70),
            
            title.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: thumbnail.topAnchor),
            name.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 20),
            name.bottomAnchor.constraint(equalTo: thumbnail.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

