//
//  ViewController.swift
//  BasicAnimation
//
//  Created by 王亮 on 2022/8/13.
//

import UIKit

class ViewController: UITableViewController {
    let items = ["Position", "Opactiy", "Rotation", "Scale", "Color"]
    
    override func loadView() {
        tableView = UITableView()
        tableView.separatorColor = .gray
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController
        switch indexPath.row {
        case 0:
            vc = PositionViewController()
        case 1:
            vc = OpacityViewController()
        case 2:
            vc = RotationViewController()
        case 3:
            vc = ScaleViewController()
        case 4:
            vc = ColorViewController()
        default:
            vc = UIViewController()
        }

        self.present(vc, animated: true)
    }
}

