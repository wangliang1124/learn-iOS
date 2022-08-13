//
//  ViewController.swift
//  MosaicLayout
//
//  Created by 王亮 on 2022/8/13.
//

import UIKit
import FMMosaicLayout

class ViewController: UICollectionViewController {
    let imageArray = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"]
    
    override func loadView() {
        let mosaicLayout = FMMosaicLayout()
        self.collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: mosaicLayout)
        self.collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = .black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(MyUICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? MyUICollectionViewCell else {
            return MyUICollectionViewCell()
        }
//        let imageView = UIImageView(image: UIImage(named: imageArray[indexPath.row]))
//        cell.contentView.addSubview(imageView)
        
        cell.imageView.image = UIImage(named: imageArray[indexPath.row])
        cell.alpha = 0
        
        let cellDelay = UInt64(arc4random() % 600 / 1000)
        let cellDelayTime = DispatchTime(uptimeNanoseconds: cellDelay * NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: cellDelayTime, execute: {
            UIView.animate(withDuration: 0.8, animations: {
                cell.alpha = 1.0
            })
        })
        
        return cell
    }
}

extension ViewController: FMMosaicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        return indexPath.item % 7 == 0 ? .big :.small
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
}
