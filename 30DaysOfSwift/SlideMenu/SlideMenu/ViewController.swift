//
//  ViewController.swift
//  SlideMenu
//
//  Created by 王亮 on 2022/7/29.
//

import UIKit

class ViewController: BaseTableViewController, UIViewControllerTransitioningDelegate {
    let reuseIdentifier = "NewsTableViewCell"
    
//    var menuTableViewController: MenuTableViewController
    
//    override init(style: UITableView.Style) {
//        super.init(style: style)
//        let vc = MenuTableViewController()
//        let menuTransitionManager = MenuTransitionManager()
//
//        vc.transitioningDelegate = menuTransitionManager
//        menuTransitionManager.delegate = self
//
//    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let menuTableViewController = segue.destination as! MenuTableViewController
//        menuTableViewController.currentItem = self.title!
//        menuTableViewController.transitioningDelegate = menuTransitionManager
//        menuTransitionManager.delegate = self
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.view.backgroundColor = UIColor(red:0.062, green:0.062, blue:0.07, alpha:1)
        tableView.separatorStyle = .none
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        navigationItem.title = "Everyday Moments"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
     
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openMenu))
        

        self.navigationController?.delegate = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsTableViewCell
        let cell = NewsTableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        
        if indexPath.row == 0 {
            cell.postImageVIew.image =  UIImage(named: "1")
            cell.authorImageView.image = UIImage(named: "a")
            cell.postTitle.text = "Love mountain."
            cell.postAuthor.text = "Allen Wang"
        } else if indexPath.row == 1 {
            cell.postImageVIew.image =  UIImage(named: "2")
            cell.authorImageView.image = UIImage(named: "b")
            cell.postTitle.text = "New graphic design - LIVE FREE"
            cell.postAuthor.text = "Cole"
        } else if indexPath.row == 2 {
            cell.postImageVIew.image =  UIImage(named: "3")
            cell.authorImageView.image = UIImage(named: "c")
            cell.postTitle.text = "Summer sand"
            cell.postAuthor.text = "Daniel Hooper"
        } else {
            cell.postImageVIew.image =  UIImage(named: "4")
            cell.authorImageView.image = UIImage(named: "d")
            cell.postTitle.text = "Summer sand"
            cell.postAuthor.text = "Daniel Hooper"
        }
        
        return cell
    }
    
    @objc
    func openMenu() {
        let vc = MenuTableViewController()
//        let menuTransitionManager = MenuTransitionManager()
//
//        vc.transitioningDelegate = menuTransitionManager
//        menuTransitionManager.delegate = self
//        vc.modalPresentationStyle = .custom
//        self.present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: MenuTransitionManagerDelegate {
    func dismiss() {
//        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let menuTransitionManager = MenuTransitionManager()
        menuTransitionManager.delegate = self
        return  menuTransitionManager
    }
}
