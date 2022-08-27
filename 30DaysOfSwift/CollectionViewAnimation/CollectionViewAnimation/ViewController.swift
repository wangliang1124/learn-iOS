//
//  ViewController.swift
//  CollectionViewAnimation
//
//  Created by 王亮 on 2022/8/9.
//

import UIKit

class ViewController: UICollectionViewController {
    static let CellIdentifier = "AnimationCollectionViewCell"
    lazy var imageCollection: AnimationImageCollection = AnimationImageCollection()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func loadView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 340, height: 210)
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(AnimationCollectionViewCell.self, forCellWithReuseIdentifier: ViewController.CellIdentifier)
    }
    
    // MARK: - UICollectionViewDataSouce
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCollection.images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewController.CellIdentifier, for: indexPath) as? AnimationCollectionViewCell else {
            return AnimationCollectionViewCell()
        }
        let vm = imageCollection.images[indexPath.row]
        cell.prepareCell(viewModel: vm)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? AnimationCollectionViewCell else {
            return
        }
        
        self.handleAnimationCellSelected(collectionView, cell: cell, indexPath: indexPath)
    }
    
    func handleAnimationCellSelected(_ collectionView: UICollectionView, cell: AnimationCollectionViewCell, indexPath: IndexPath) {
        cell.handleCellSelected()
        cell.backButtonTapped = {
            collectionView.isScrollEnabled = true
            collectionView.reloadItems(at: [indexPath])
        }
        
        let animations = {
            cell.frame.origin = CGPoint(x: 0, y: collectionView.contentOffset.y)
            cell.frame.size = UIScreen.main.bounds.size
        }
        
        let completion: ((_ finished: Bool) -> Void) = { _ in
//            collectionView.isScrollEnabled = false
        }
        
        // FIXME: animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: animations, completion: completion)
    }
    
//    func backButtonDidTouch(cell: AnimationCollectionViewCell){
//        guard let indexPath = self.collectionView.indexPath(for: cell) else {
//            return
//        }
//
//        collectionView.isScrollEnabled = true
//        collectionView.reloadItems(at: [indexPath])
//    }
}

