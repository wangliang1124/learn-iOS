//
//  ViewController.swift
//  Carousel
//
//  Created by 王亮 on 2022/7/3.
//

import UIKit

fileprivate let CellIdentifier = "InterestCell"
fileprivate let CellPadding: CGFloat = 20.0

class HomeViewController: UIViewController {
    var backgroundImageView: UIImageView = {
        return UIImageView(image: UIImage(named: "blue"))
    }()
    var collectionView: UICollectionView!
    var currentUserProfileImageButton: UIButton!
    var currentUserFullNameButton: UIButton!
    
    fileprivate var interests = Interest.createInterests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurEffectView.frame = self.view.bounds
        backgroundImageView.frame = self.view.bounds
       
        view.addSubview(backgroundImageView)
        view.addSubview(blurEffectView)
        view.addSubview(collectionView)
        
     
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        return InterestCollectionViewCell(interest: interests[indexPath.row]) // todo
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! InterestCollectionViewCell
        cell.interest = interests[indexPath.row]
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 4 * CellPadding, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2 * CellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: CellPadding, bottom: 0, right: CellPadding)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
}
