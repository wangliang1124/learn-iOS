//
//  ViewController.swift
//  CoreDataApp
//
//  Created by 王亮 on 2022/8/13.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    var listItems = [String]()
    
    var storedData: [NSManagedObject] = [NSManagedObject]() {
        didSet {
            print("storedData:\(storedData)")
            for item in storedData {
                if let value = item.value(forKey: "item") as? String {
                    listItems.append(value)
                }
            }
        }
    }
    
    override func loadView() {
        tableView = UITableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.managedObjectContext
        
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MyListEntity")
            if let results = try managedContext?.fetch(fetchRequest) as? [NSManagedObject] {
                
                self.storedData = results
                self.tableView.reloadData()
            }
        } catch  {
            print(error)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
    }
    
    @objc func addItem() {
        let alertController = UIAlertController(title: "New Resolution", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Type someting..."
        })
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: { _ in
            if let text = alertController.textFields?.first?.text {
                self.saveItem(itemToSave: text)
                self.tableView.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func saveItem(itemToSave: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        guard let managedContext = appDelegate?.managedObjectContext else {
            return
        }
        
        guard  let entity = NSEntityDescription.entity(forEntityName: "MyListEntity", in: managedContext) else {
            return
        }
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(itemToSave, forKey: "item")
        
        
        do {
            try managedContext.save()
            self.listItems.append(itemToSave)
        } catch {
            print("\(#function):\(error)")
        }
    }
    
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let item = listItems[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { (action, sourceView, completionHandler) in
     
           
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            managedContext?.delete(self.storedData[indexPath.row])
            do {
                try managedContext?.save()
                
                self.listItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .right)
//                tableView.reloadRows(at: [indexPath], with: .right)
            } catch {
                print("error: delete ")
            }
            
            
            completionHandler(true)
        })
        
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    //    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    //        return true
    //    }
}

