//
//  MessageViewController.swift
//  WeChat
//
//  Created by 王亮 on 2023/2/19.
//

import UIKit

class MessageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "微信"
        self.view.backgroundColor = .viewBackgroundColor
        self.tableView.register(MessageTableCell.self, forCellReuseIdentifier: "MessageTableCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MessageTableCell
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: "MessageTableCell") as? MessageTableCell {
           cell = reusableCell
        } else {
            cell = MessageTableCell()
        }
        
        cell.textLabel?.text = "test"
        
        
        return cell
    }
}

