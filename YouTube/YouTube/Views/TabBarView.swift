//
//  TabBarView.swift
//  YouTube
//
//  Created by 王亮 on 2022/12/5.
//

import UIKit

class TabBarView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    private let tabBarImages = ["home", "trending", "subscriptions", "account"]
    var collectionView: UICollectionView!
    var whiteBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var selectedIndex = 0
    var whiteBarLeadingConstraint: NSLayoutConstraint!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TableViewCell.self, forCellWithReuseIdentifier: "TableViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(collectionView)
        self.collectionView.backgroundColor = UIColor.rgb(r: 228, g: 34, b: 24)
        
        self.addSubview(whiteBar)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor),
            whiteBar.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            whiteBar.heightAnchor.constraint(equalToConstant: 5),
            whiteBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4)
        ])
        
        whiteBarLeadingConstraint = whiteBar.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        whiteBarLeadingConstraint.isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(animateMenu), name: Notification.Name(rawValue: "scrollMenu"), object: nil)
    }
    
    @objc func animateMenu(notification: Notification) {
        if let info = notification.userInfo as? [String: CGFloat],
        let length = info["length"] {
            self.whiteBarLeadingConstraint.constant = self.whiteBar.bounds.width * length
            self.selectedIndex = Int(round(length))
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabBarImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        var image = self.tabBarImages[indexPath.row]
        if self.selectedIndex == indexPath.row {
            image += "Selected"
        }

        cell.icon.image = UIImage(named: image)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 4, height: collectionView.bounds.height)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension TabBarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.selectedIndex != indexPath.row {
            self.selectedIndex  = indexPath.row
            self.collectionView.reloadData()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didSelectMenu"), object: nil, userInfo: ["index": self.selectedIndex])
        }
    }
}


class TableViewCell: UICollectionViewCell {
    var icon: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(icon)
       
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: self.topAnchor),
            icon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            icon.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
