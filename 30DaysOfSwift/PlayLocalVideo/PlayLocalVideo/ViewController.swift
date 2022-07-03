//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by 王亮 on 2022/6/28.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    var data = [
        Video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        Video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        Video(image: "videoScreenshot03", title: "Seals Documentary", source: "Youtube - 06:32"),
        Video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 06:32"),
        Video(image: "videoScreenshot05", title: "Facebook HQ", source: "Youtube - 06:32"),
        Video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Youtube - 06:32"),
    ]
    
    var videoTableView: UITableView!
//    var playVideoButton: UIButton = {
//        let btn = UIButton()
//        btn.addTarget(self, action: #selector(play), for: .touchUpInside)
//        return btn
//    }()
    
    var playViewController = AVPlayerViewController()
    var playerView = AVPlayer()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        videoTableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        videoTableView.dataSource = self
        videoTableView.delegate = self
        
        view.addSubview(videoTableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func play(){
        print("play")

        if let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4") {
            playerView = AVPlayer(url: URL(fileURLWithPath: path))
            playViewController.player = playerView
            
            self.present(playViewController, animated: true, completion: {
                self.playViewController.player?.play()
            })
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = data[indexPath.row]
        let cell = VideoCell(style: .value1, reuseIdentifier: "VideoCell") //VideoCell(videoScreenshot: UIImage(named: video.image) ?? nil, videoTitle: video.title, videoSource: video.source)
//        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        cell.videoScreenshot.image = UIImage(named: video.image)
        cell.videoTitle.text = video.title
        cell.videoSource.text = video.source
        cell.playVideoButton.addTarget(self, action: #selector(play), for: .touchUpInside)
        return cell
    }
}
