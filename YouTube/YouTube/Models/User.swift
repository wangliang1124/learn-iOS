//
//  User.swift
//  YouTube
//
//  Created by 王亮 on 2022/11/20.
//

import Foundation
import UIKit

class User {
    let name: String
    let profilePic: UIImage
    let backgroundImage: UIImage
    var playlists: [Playlist]
    
    init(name: String, profilePic: UIImage, backgroundImage: UIImage, playlists: Array<Playlist>) {
        self.name = name
        self.profilePic = profilePic
        self.backgroundImage = backgroundImage
        self.playlists = playlists
    }
    
    func fetchData(completion: @escaping (User) -> Void) {
        //Dummy Data
        let data = ["pl-swift": "Swift Tutorials", "pl-node": "NodeJS Tutorials", "pl-javascript": "JavaScript ES6 / ES2015 Tutorials", "pl-angular": "Angular 2 Tutorials", "pl-rest": "REST API Tutorials (Node, Express & Mongo)", "pl-react": "React development", "pl-mongo": "Mongo db"]
        
        let user = User(name: "Haik Aslanyan", profilePic: UIImage.init(named: "profilePic")!, backgroundImage: UIImage(named: "banner")!, playlists: [Playlist]())
        
        for (key, value) in data {
            let image = UIImage(named: key)
            let name = value
            let playlist = Playlist(pic: image!, title: name, numberOfVideos: Int(arc4random_uniform(50)))
            
            user.playlists.append(playlist)
        }
        
        completion(user)
    }
}

struct Playlist {
    let pic: UIImage
    let title: String
    let numberOfVideos: Int
    
    init(pic: UIImage, title: String, numberOfVideos: Int) {
        self.pic = pic
        self.title = title
        self.numberOfVideos = numberOfVideos
    }
}
