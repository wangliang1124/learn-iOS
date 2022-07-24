//
//  VideoSplashViewController.swift
//  VideoBackground
//
//  Created by 王亮 on 2022/7/24.
//

import UIKit
import AVKit

class VideoSplashViewController: UIViewController {
    let moviePlayer = AVPlayerViewController()
    var moviePlayerSoundLevel: Float = 2.0
    
    var contentURL: URL? {
        didSet {
            if let _contentURL = contentURL {
                setMoviePlayer(_contentURL)
            }
        }
    }
    
    var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NotificationCenter.default.addObserver(self, selector: #selector(playItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: moviePlayer.player?.currentItem)
            }
        }
    }
    
    var startTime: CGFloat = 2.0
    var duration: CGFloat = 10.0
    
    override func viewDidAppear(_ animated: Bool) {
        moviePlayer.view.frame = UIScreen.main.bounds
        moviePlayer.view.alpha = 0.8
        moviePlayer.showsPlaybackControls = false
        moviePlayer.videoGravity = .resizeAspectFill
        view.addSubview(moviePlayer.view)
        view.sendSubviewToBack(moviePlayer.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setMoviePlayer(_ url: URL) {
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithUrl(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) -> Void in
            
            if let path = videoPath {
                DispatchQueue.main.async {
                    self.moviePlayer.player = AVPlayer(url: path)
                    self.moviePlayer.player?.play()
                    self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
                }
            }
        }
    }
    
    @objc
    func playItemDidReachEnd(){
        moviePlayer.player?.seek(to: CMTime.zero)
        moviePlayer.player?.play()
    }
}
