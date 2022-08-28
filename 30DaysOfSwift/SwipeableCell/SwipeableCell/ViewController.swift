//
//  ViewController.swift
//  SwipeableCell
//
//  Created by 王亮 on 2022/8/10.
//

import UIKit

struct TableViewCellModel {
    let image: String
    let name: String
}

var data = [
    TableViewCellModel(image: "1", name: "Pattern Building"),
    TableViewCellModel(image: "2", name: "Joe Beez"),
    TableViewCellModel(image: "3", name: "Car It's car"),
    TableViewCellModel(image: "4", name: "Floral Kaleidoscopic"),
    TableViewCellModel(image: "5", name: "Sprinkle Pattern"),
    TableViewCellModel(image: "6", name: "Palitos de queso"),
    TableViewCellModel(image: "7", name: "Ready to Go? Pattern"),
    TableViewCellModel(image: "8", name: "Sets Seamless"),
]

class ViewController: UITableViewController {
    //    override func loadView() {
    //        tableView = UITableView()
    //    }
    //
    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // 如果不注释， tableView.deleteRows(at: [indexPath], with: .right) 会 crash
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 4
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let row = data[indexPath.row]
        cell.textLabel?.text = row.name
        cell.imageView?.image = UIImage(named: row.image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete", handler: { (_, _, competionHandler)in
            print("Delete button tapped")
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
//            tableView.reloadData()
            competionHandler(true)
        })
        delete.backgroundColor = .gray
        
        let share = UIContextualAction(style: .normal, title: "Share", handler: { (_, _, competionHandler) in
            let firstActivityItem = data[indexPath.row]
            let activityViewController = UIActivityViewController(activityItems: [firstActivityItem.image as NSString], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
            competionHandler(true)
        })
        share.backgroundColor = .red
        
        let download = UIContextualAction(style: .normal, title: "Download", handler: { (action, sourceView, competionHandler) in
            print("Download button tapped")
            competionHandler(true)
        })
        //        let download = UITableViewRowAction(style: .normal, title: "Download", handler: { (_, _) in
        //            print("Download button tapped")
        //        })
        download.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [download, share, delete])
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("Delete")
        case .insert:
            print("Insert")
        case .none:
            print("None")
        @unknown default:
            print("Default")
        }
    }
}

