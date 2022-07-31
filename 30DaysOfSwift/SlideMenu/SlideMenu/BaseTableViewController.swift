//
//  BaseTableViewController.swift
//  SlideMenu
//
//  Created by 王亮 on 2022/7/29.
//

import UIKit

class BaseTableViewController: UITableViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}
