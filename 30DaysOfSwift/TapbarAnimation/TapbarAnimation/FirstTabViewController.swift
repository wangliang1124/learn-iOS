//
//  FirstTabViewController.swift
//  TapbarAnimation
//
//  Created by 王亮 on 2022/8/14.
//

import Foundation
import UIKit

var data = [
    article(avatarImage: "allen", sharedName: "Allen Wang", actionType: "Read Later", articleTitle: "Giphy Cam Lets You Create And Share Homemade Gifs", articleCoverImage: "giphy", articleSouce: "TheNextWeb", articleTime: "5min  •  13:20"),
    article(avatarImage: "Daniel Hooper", sharedName: "Daniel Hooper", actionType: "Shared on Twitter", articleTitle: "Principle. The Sketch of Prototyping Tools", articleCoverImage: "my workflow flow", articleSouce: "SketchTalk", articleTime: "3min  •  12:57"),
    article(avatarImage: "davidbeckham", sharedName: "David Beckham", actionType: "Shared on Facebook", articleTitle: "Ohlala, An Uber For Escorts, Launches Its ‘Paid Dating’ Service In NYC", articleCoverImage: "Ohlala", articleSouce: "TechCrunch", articleTime: "1min  •  12:59"),
    article(avatarImage: "bruce", sharedName: "Bruce Fan", actionType: "Shared on Weibo", articleTitle: "Lonely Planet’s new mobile app helps you explore major cities like a pro", articleCoverImage: "Lonely Planet", articleSouce: "36Kr", articleTime: "5min  •  11:21"),
]

class FirstTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var articleTableView = UITableView()
    
    override func loadView() {
        self.view = articleTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTableView.delegate = self
        articleTableView.dataSource = self
        articleTableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        articleTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animateTable()
    }
    
    func animateTable() {
        self.articleTableView.reloadData()
        
        let tableViewHeight = articleTableView.bounds.size.height
        let cells = articleTableView.visibleCells
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        
        var index = 0
        
        for cell in cells {
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = .identity //CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        let article = data[indexPath.row]
        
        cell.avatarImage.image = UIImage(named: article.avatarImage)
        cell.articleCoverImage.image = UIImage(named: article.articleCoverImage)
        cell.sharedNameLabel.text = article.sharedName
        cell.actionTypeLabel.text = article.actionType
        cell.articleTitleLabel.text = article.articleTitle
        cell.articleSouceLabel.text = article.articleSouce
        cell.articelCreatedAtLabel.text = article.articleTime
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
}
