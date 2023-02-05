//
//  Video.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/20.
//

import Foundation
import UIKit

class Video {
    let thumbnail: UIImage
    let title: String
    let views: Int
    let channel: Channel
    let duration: Int
    let likes: Int
    let disLikes: Int
    var videoLink: URL!
    var suggestedVideos = [SuggestedVideo]()
    
    init( title: String, channelName: String) {
        self.thumbnail = UIImage(named: title)!
        self.title = title
        self.views = Int(arc4random_uniform(100_000))
        self.duration = Int(arc4random_uniform(400))
        self.likes = Int(arc4random_uniform(1_000))
        self.disLikes = Int(arc4random_uniform(1_000))
        self.channel = Channel(name: channelName, image: UIImage(named: channelName)!)
    }
    
    class func fetchVideos(completion: @escaping ([Video]) -> Void) {
        let video1 = Video(title: "What Does Jared Kushner Believe", channelName: "Nerdwriter1")
        let video2 = Video(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
        let video3 = Video(title: "What Bill Gates is afraid of", channelName: "Vox")
        let video4 = Video(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
        let video5 = Video(title: "A New History for Humanity – The Human Era", channelName: "Kurzgesagt – In a Nutshell")
        let video6 = Video(title: "Neural Network that Changes Everything - Computerphile", channelName: "Computerphile")
        let video7 = Video(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let video8 = Video(title: "Scott Galloway: The Retailer Growing Faster Than Amazon", channelName: "L2inc")
        var items = [video1, video2, video3, video4, video5, video6, video7, video8]
        items.myShuffle()
        completion(items)
    }
    
    class func fetchVideo(completion: @escaping (Video) -> Void) {
        let video = Video(title: "Big Buck Bunny", channelName: "Blender Foundation")
        video.videoLink = URL(string: "http://sample-videos.com/video/mp4/360/big_buck_bunny_360p_10mb.mp4")!
        
        let suggestedVideo1 = SuggestedVideo(title: "What Does Jared Kushner Believe", channelName: "Nerdwriter1")
        let suggestedVideo2 = SuggestedVideo(title: "Moore's Law Is Ending. So, What's Next", channelName: "Seeker")
        let suggestedVideo3 = SuggestedVideo(title: "What Bill Gates is afraid of", channelName: "Vox")
        let suggestedVideo4 = SuggestedVideo(title: "Why Can't America Have a Grown-Up Healthcare Conversation", channelName: "vlogbrothers")
        let suggestedVideo5 = SuggestedVideo(title: "TensorFlow Basics - Deep Learning with Neural Networks p. 2", channelName: "sentdex")
        let items = [suggestedVideo1, suggestedVideo2, suggestedVideo3, suggestedVideo4, suggestedVideo5]
        video.suggestedVideos = items
        
        completion(video)
    }
}


struct SuggestedVideo {
    let title: String
    let channelName: String
    let thumbnail: UIImage
    
    init(title: String, channelName: String) {
        self.title = title
        self.channelName = channelName
        self.thumbnail = UIImage(named: title)!
    }
}

class Channel {
    let name: String
    let image: UIImage
    var subscribers = 0
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
    
    class func fetch(completion: @escaping ([Channel]) -> Void) {
        var items = [Channel]()
        for i in 0...18 {
            let name = ""
            let image = UIImage(named: "channel\(i)")!
            let channel = Channel(name: name, image: image)
            
            items.append(channel)
        }
        
        
        completion(items)
    }
}
