//
//  ViewController.swift
//  RandomGradientColorMusic
//
//  Created by 王亮 on 2022/7/22.
//

import UIKit
import AVFoundation

typealias BackgroudColor = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

class ViewController: UIViewController {
    var audioPlayer = AVAudioPlayer()
    var gradientLayer = CAGradientLayer()

    var playBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "music play"), for: .normal)
       
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    var timer: Timer?
    
    var backgroundColor: BackgroudColor! {
        didSet {
            let color1 = UIColor(red: backgroundColor.blue, green: backgroundColor.green, blue: 0, alpha: backgroundColor.alpha).cgColor
            
            let color2 = UIColor(red: backgroundColor.red,
                                            green: backgroundColor.green,
                                            blue: backgroundColor.blue,
                                            alpha: backgroundColor.alpha).cgColor
            
            gradientLayer.colors = [color1, color2]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        playBtn.addTarget(self, action: #selector(play), for: .touchUpInside)
        playBtn.layer.zPosition = 1
        view.addSubview(playBtn)
        view.backgroundColor = .clear
        
        view.layer.addSublayer(gradientLayer)
        
        
        NSLayoutConstraint.activate([
            playBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func play(){
        if let musicFile = Bundle.main.path(forResource: "Ecstasy", ofType: "mp3") {
            let music = URL(fileURLWithPath: musicFile)
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                try AVAudioSession.sharedInstance().setActive(true)
                try audioPlayer = AVAudioPlayer(contentsOf: music)
                
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch let audioError {
                print(audioError)
            }
            
            
            if timer == nil {
                timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(randomColor), userInfo: nil, repeats: true)
            }
            
//            let red = CGFloat(drand48())
//            let green = CGFloat(drand48())
//            let blue = CGFloat(drand48())
//
//            self.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
//
            gradientLayer.frame = view.bounds
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            
           
        }
    }
    
    @objc func randomColor(){
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        backgroundColor = (red, green, blue, 1)
    }
}

