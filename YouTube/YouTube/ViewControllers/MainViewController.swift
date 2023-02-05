//
//  MainViewController.swift
//  YouTube
//
//  Created by 王亮 on 2022/12/11.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    lazy var tabBarView: TabBarView = TabBarView()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
//        flowLayout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isDirectionalLockEnabled = true
        return collectionView
    }()


    var views = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")

        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollViews), name: Notification.Name(rawValue: "didSelectMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideBar(notification:)), name: Notification.Name(rawValue: "hide"), object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.rgb(r: 228, g: 34, b: 24)

//        self.collectionView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
//        self.collectionView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.bounds.height)
        self.view.addSubview(collectionView)
        
        self.view.addSubview(self.tabBarView)
        self.tabBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tabBarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 88),
            self.tabBarView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tabBarView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tabBarView.heightAnchor.constraint(equalToConstant: 64),
        ])
        
        
        let homeVC = HomeViewController()
        let trendingVC = TrendingViewController()
        let subscriptionVC = SubscriptionsViewController()
        let accountVC = AccountViewController()
 
        
        let viewControllers = [homeVC, trendingVC, subscriptionVC, accountVC]
        
        for vc in viewControllers {
            self.addChild(vc)
            vc.didMove(toParent: self)
            vc.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height - 44)
            self.views.append(vc.view)
        }
        
        self.collectionView.reloadData()
    }
    
    @objc func scrollViews(notification: Notification) {
        if let info = notification.userInfo as? [String: Int],
        let index = info["index"] {
            print(index)
//            self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = false
            collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    @objc func hideBar(notification: Notification) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.views.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.contentView.addSubview(self.views[indexPath.row])
        return cell
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollIndex = scrollView.contentOffset.x / self.view.bounds.width
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "scrollMenu"), object: nil, userInfo: ["length": scrollIndex])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height: self.collectionView.bounds.height + 22)
    }
}
