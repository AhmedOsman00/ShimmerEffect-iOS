//
//  PrepareForShimmer.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 10/21/20.
//

import UIKit

public protocol PrepareForShimmer {
    func prepareForShimmer()
}

extension UICollectionViewCell {
    open override func prepareForReuse() {
        super.prepareForReuse()
        self.hideShimmerEffect()
    }
}
