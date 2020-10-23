//
//  Collection.swift
//  ShimmerEffect-iOS_Example
//
//  Created by Ahmed Osman on 10/23/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ShimmerEffect_iOS

class CollectionCell: UICollectionViewCell, PrepareForShimmer {
    
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
    
    func prepareForShimmer() {
        label.isHidden = true
    }
}
