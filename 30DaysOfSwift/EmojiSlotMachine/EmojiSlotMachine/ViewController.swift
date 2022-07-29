//
//  ViewController.swift
//  EmojiSlotMachine
//
//  Created by 王亮 on 2022/7/28.
//

import UIKit

class ViewController: UIViewController {
    var emojis = ["👻","👸","💩","😘","🍔","🤖","🍟","🐼","🚖","🐷"]
    var data1 = [Int]()
    var data2 = [Int]()
    var data3 = [Int]()
    
    
    var emojiPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        return pickerView
    }()
    
    var goButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.background.backgroundColor = .orange
        config.baseForegroundColor = .purple
        config.attributedTitle = AttributedString("Go", attributes: AttributeContainer([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
        let btn = UIButton(configuration: config)
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var magicButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Normal", for: .normal)
        btn.titleLabel?.textColor = .white
        btn.backgroundColor = .red
        btn.layer.cornerRadius = 5
        btn.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var goButtonBounds = CGRect.zero
    
    var magicFlag = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPickerViewData()
        
        emojiPickerView.delegate = self
        emojiPickerView.dataSource = self
        
        goButton.addTarget(self, action: #selector(goButtonDidTouch), for: .touchUpInside)
        goButtonBounds = goButton.bounds
        
        magicButton.addTarget(self, action: #selector(magicButtonDidTouch), for: .touchUpInside)
        
        view.addSubview(resultLabel)
        view.addSubview(emojiPickerView)
        view.addSubview(goButton)
        view.addSubview(magicButton)
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emojiPickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiPickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goButton.heightAnchor.constraint(equalToConstant: 45),
            goButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160),
            goButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            magicButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            magicButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        goButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseIn, animations: {
            self.goButton.alpha = 1
        }, completion: nil)
    }
    
    func initPickerViewData() {
        for _ in 0...100 {
            data1.append((Int)(arc4random() % 10))
            data2.append((Int)(arc4random() % 10))
            data3.append((Int)(arc4random() % 10))
        }
    }
    
    @objc
    func goButtonDidTouch(){
        var index1: Int
        var index2: Int
        var index3: Int
        
        if magicFlag {
            index1 = Int(arc4random() % 90) + 3
            index2 = data2.firstIndex(of: data1[index1]) ?? index1
            index3 = data3.lastIndex(of: data1[index1]) ?? index1
            print(index1, index2, index3)
            print(data1[index1], data2[index2], data3[index3])
        } else {
            index1 = Int(arc4random() % 90) + 3
            index2 = Int(arc4random() % 90) + 3
            index3 = Int(arc4random() % 90) + 3
        }
        
        emojiPickerView.selectRow(index1, inComponent: 0, animated: true)
        emojiPickerView.selectRow(index2, inComponent: 1, animated: true)
        emojiPickerView.selectRow(index3, inComponent: 2, animated: true)

        
        if data1[emojiPickerView.selectedRow(inComponent: 0)] == data2[emojiPickerView.selectedRow(inComponent: 1)],
           data2[emojiPickerView.selectedRow(inComponent: 1)] == data3[emojiPickerView.selectedRow(inComponent: 2)] {
            resultLabel.text = "Bingo!"
            resultLabel.textColor = .white
           
        } else {
            resultLabel.text = "💔"
        }
  
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {
            let origin = self.goButtonBounds.origin
            let size = self.goButtonBounds.size
            self.goButton.bounds = CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
        }, completion: { compelete in
//            let origin = self.goButtonBounds.origin
//            let size = self.goButtonBounds.size
//
//            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
//                self.goButton.bounds =  CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
//            }, completion: nil)
//
        })
        
    }
    
    @objc
    func magicButtonDidTouch(_ sender: UIButton) {
        magicFlag = !magicFlag
        sender.setTitle(magicFlag ? "Super" : "Normal", for: .normal)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont(name: "Apple Color Emoji", size: 80)
        label.textAlignment = .center
        
        if component == 0 {
            label.text = emojis[data1[row]]
        } else if component == 1 {
            label.text = emojis[data2[row]]
        } else {
            label.text = emojis[data3[row]]
        }
        
        return label
    }
}
