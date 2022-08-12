//
//  BackTableViewController.swift
//  SlideoutMenu
//
//  Created by 王亮 on 2022/8/12.
//

import Foundation

class BackTableViewController: UITableViewController {
    var menuList = ["FriendRead", "Article", "ReadLater"]
    
    override func viewDidLoad() {
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.separatorColor = UIColor(red:0.159, green:0.156, blue:0.181, alpha:1)
        self.view.backgroundColor = .black
        for item in menuList {
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: item)
        }

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuList[indexPath.row], for: indexPath)
        cell.textLabel?.text = menuList[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = tableView.cellForRow(at: indexPath)
        selectedRow?.contentView.backgroundColor = UIColor(red:0.245, green:0.247, blue:0.272, alpha:0.817)
    }
}
