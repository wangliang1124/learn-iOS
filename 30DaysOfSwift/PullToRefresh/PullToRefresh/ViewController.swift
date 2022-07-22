//
//  ViewController.swift
//  PullToRefresh
//
//  Created by 王亮 on 2022/7/22.
//

import UIKit

class ViewController: UITableViewController {
    let cellIdentifer = "NewCellIdentifier"
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    
    var emojiData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emojiData = favoriteEmoji.shuffled()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        
        let refreshControl =  UIRefreshControl()
        refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        refreshControl.tintColor = .white
        refreshControl.attributedTitle = NSAttributedString(string: "Last update on \(Date())", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        refreshControl.addTarget(self, action: #selector(didLoadEmoji), for: .valueChanged)
        self.refreshControl = refreshControl
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifer)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        
        cell.textLabel?.text = emojiData[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
//        cell.textLabel?.textAlignment = .center
        cell.detailTextLabel?.text = "detail"
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        return cell
    }
    
    @objc
    func didLoadEmoji() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            self.emojiData = self.emojiData + self.newFavoriteEmoji.shuffled()
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })
    }
}

