//
//  UIArray+ShimmerEffect.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 11/17/20.
//

import UIKit

public extension Array where Element == UIView {
    func showShimmerEffect(properties: ShimmerProperties = ShimmerProperties()) {
        self.forEach({ $0.showShimmerEffect(properties: properties) })
    }
    
    func hideShimmerEffect() {
        self.forEach({ $0.hideShimmerEffect() })
    }
}

extension Array where Element == UIView {
    internal func removeFromSuperview() {
        self.forEach({ $0.removeFromSuperview() })
    }
}
