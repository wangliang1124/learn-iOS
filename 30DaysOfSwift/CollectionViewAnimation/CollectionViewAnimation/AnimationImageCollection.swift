//
//  AnimationImageCollection.swift
//  CollectionViewAnimation
//
//  Created by 王亮 on 2022/8/9.
//

import UIKit

struct AnimationCellModel {
    let imagePath: String
    
    init(imagePath: String?){
        self.imagePath = imagePath ?? ""
    }
}


struct AnimationImageCollection {
    private let imagePaths = ["1", "2", "3", "4", "5"]
    var images: [AnimationCellModel]
    
    init() {
        images = imagePaths.map {
            AnimationCellModel(imagePath: $0)
        }
    }
}
