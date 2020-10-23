//
//  TableCell.swift
//  ShimmerEffect-iOS_Example
//
//  Created by Ahmed Osman on 10/23/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import ShimmerEffect_iOS

class TableCell: UITableViewCell, PrepareForShimmer {
   
    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.isHidden = false
    }
    
    func prepareForShimmer() {
        label.isHidden = true
    }
}
