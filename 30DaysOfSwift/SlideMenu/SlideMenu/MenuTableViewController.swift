//
//  MenuTableViewController.swift
//  SlideMenu
//
//  Created by 王亮 on 2022/7/29.
//

import UIKit

class MenuTableViewController: BaseTableViewController {
    private let reuseIdentifier = "MenuTableViewCell"
    var menuItems = ["Everyday Moments", "Popular", "Editors", "Upcoming", "Fresh", "Stock-photos", "Trending"]
    var currentItem = "Everyday Moments"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.frame = UIScreen.main.bounds

        view.backgroundColor = UIColor(red: 0.109, green: 0.114, blue: 0.128, alpha: 1)
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = menuItems[indexPath.row] == currentItem ? .white : .gray
        cell.backgroundColor = .clear

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
        currentItem = menuItems[indexPath.row]
    }
}
