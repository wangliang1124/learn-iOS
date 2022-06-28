//
//  ViewController.swift
//  CustomFont
//
//  Created by 王亮 on 2022/6/27.
//

import UIKit

private let data = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」",
                    "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体",
                    "呵呵，再见🤗 See you next Project", "微博 @Allen朝辉",
                    "测试测试测试测试测试测试", "123", "Alex", "@@@@@@"]

private var fontNames = ["MFTongXin_Noncommercial-Regular",
                         "MFJinHei_Noncommercial-Regular",
                         "MFZhiHei_Noncommercial-Regular",
                         "Zapfino",
                         "Gaspar Regular"]


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    static let identifier = "FontCell"
    
    private lazy var fontTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    //    var fontTableView: UITableView
    
    private var fontIndex = 0
    
    var changeBtn: UILabel =  {
        let label = UILabel()
        label.text = "Change Font"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .blue
        label.backgroundColor = .yellow
        label.layer.cornerRadius = 50
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //
    //    init(){
    //        super.init(nibName: nil, bundle: nil)
    //
    //    }
    
    required init?(coder: NSCoder) {
        //        self.fontTableView = UITableView(frame: self.tableview, style: .grouped)
        super.init(coder: coder)
        fontTableView.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.identifier)
        //        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //        for fontFamily in UIFont.familyNames {
        //            print(fontFamily)
        //            for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
        //                print(fontFamily + ":" + fontName)
        //            }
        //        }
        
        
        
        self.view.backgroundColor = .black
        view.addSubview(fontTableView)
        view.addSubview(changeBtn)
        
        changeBtn.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeFont))
        changeBtn.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            fontTableView.topAnchor.constraint(equalTo: view.topAnchor),
            fontTableView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            fontTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fontTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            changeBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeBtn.widthAnchor.constraint(equalToConstant: 100),
            changeBtn.heightAnchor.constraint(equalToConstant: 100),
            changeBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        ])
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = UITableViewCell(style: .default, reuseIdentifier: ViewController.identifier)
        let cell = fontTableView.dequeueReusableCell(withIdentifier: ViewController.identifier, for: indexPath)
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: fontNames[fontIndex], size: 16)
        cell.backgroundColor = .black
        
        return cell
    }
    
    @objc func changeFont(){
        print("change font")
        //        changeBtn.alpha = 0.5
        fontIndex = (fontIndex + 1) % 5
        print(fontNames[fontIndex])
        fontTableView.reloadData()
    }
}

