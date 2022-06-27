//
//  UI.swift
//  StopWatch
//
//  Created by 王亮 on 2022/6/22.
//

import Foundation
import UIKit

class UI: UIView {
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Play", for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.backgroundColor = .blue
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(play), for: .touchUpInside)
        
        return btn
    }()
    
    private let pauseBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Pause", for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        btn.backgroundColor = .green
        btn.isEnabled = false
        btn.alpha = 0.5
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(pause), for: .touchUpInside)
        return btn
    }()
    
    private let resetBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("reset", for: UIControl.State.normal)
        btn.titleLabel?.font =  UIFont.systemFont(ofSize: 18)
        btn.setTitleColor(.orange, for: .normal)
//        btn.contentHorizontalAlignment = .fill
//        btn.contentVerticalAlignment = .fill
//        btn.imageView?.contentMode = .scaleAspectFit
//        btn.setImage(UIImage(named: "reset"), for: .normal)
//        btn.imageView?.translatesAutoresizingMaskIntoConstraints = false
//        btn.imageView?.backgroundColor = .gray
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(reset), for: .touchUpInside)
        return btn
    }()
    
    private var counter: Float = 0.0 {
        didSet {
            timeLabel.text = String(format: "%.1f", counter)
        }
    }
    
    var timer: Timer? = Timer()
    
//    convenience init() {
//        let frame = UIScreen.main.bounds
//        self.init(frame: frame)
//    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addSubview(timeLabel)
        addSubview(playBtn)
        addSubview(pauseBtn)
        addSubview(resetBtn)
        
        let topConstraint = timeLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        let centerConstraint = timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        
        topConstraint.isActive = true
        centerConstraint.isActive = true
        
        timeLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
       
        resetBtn.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 10).isActive = true
        resetBtn.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: -18).isActive = true
//        resetBtn.widthAnchor.constraint(equalToConstant: 160).isActive = true
//        resetBtn.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
//        resetBtn.imageView?.topAnchor.constraint(equalTo: resetBtn.topAnchor).isActive = true
//        resetBtn.imageView?.bottomAnchor.constraint(equalTo: resetBtn.bottomAnchor).isActive = true
//        resetBtn.imageView?.rightAnchor.constraint(equalTo: resetBtn.centerXAnchor).isActive = true
//        resetBtn.imageView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        resetBtn.imageView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
       
        
        
        NSLayoutConstraint.activate([
            playBtn.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            playBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            playBtn.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            playBtn.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            pauseBtn.topAnchor.constraint(equalTo: timeLabel.bottomAnchor),
            pauseBtn.leadingAnchor.constraint(equalTo: playBtn.trailingAnchor),
            pauseBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pauseBtn.heightAnchor.constraint(equalTo: playBtn.heightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func play(){
        print("play")
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        playBtn.isEnabled = false
        pauseBtn.isEnabled = true
        playBtn.alpha = 0.5
        pauseBtn.alpha = 1
    }
    
    @objc func pause(){
        print("pause")
        if let timer = timer {
            timer.invalidate()
        }
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        playBtn.alpha = 1
        pauseBtn.alpha = 0.5
    }
    
    @objc func reset(){
        print("reset")
        counter = 0
        if let timer = timer {
            timer.invalidate()
        }
        timer = nil
        playBtn.isEnabled = true
        pauseBtn.isEnabled = false
        
        playBtn.alpha = 1
        pauseBtn.alpha = 0.5
    }
    
    
    @objc func updateTimer() {
        counter += 0.1
    }
}

//extension UIView {
//    var translatesAutoresizingMaskIntoConstraints {
//        didSet {
//
//        }
//    }
//}
