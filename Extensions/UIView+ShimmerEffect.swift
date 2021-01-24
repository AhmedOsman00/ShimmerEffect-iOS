//
//  UIView+Shimmer.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/24/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

public extension UIView {
    
    @IBInspectable var isShimmering: Bool {
        get { return objc_getAssociatedObject(self, &UIView.shimmer) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &UIView.shimmer, newValue, AssociationPolicy.retainNonatomic.objc) }
    }
    
    func showShimmerEffect(properties: ShimmerProperties = ShimmerProperties()) {
        let subviews = self.subviewsRecursive()
        self.replaceTableViewOriginalDataSource(subviews)
        self.replaceCollectionViewOriginalDataSource(subviews)
        let shimmerViews = self.getSubViewsForShimmer(subviews)
        for shimmerView in shimmerViews {
            shimmerView.addShimmerView(to: shimmerView, with: properties)
            shimmerView.didAddShimmerView(shimmerView)
        }
    }
    
    @objc func didRemoveShimmerView(_ shimmerView: UIView) {}
    
    @objc func didAddShimmerView(_ shimmerView: UIView) {}
    
    func hideShimmerEffect() {
        let subviews = self.subviewsRecursive()
        let views = self.getSubViewsForShimmer(subviews)
        for view in views {
            let shimmerViews = view.subviews.filter({ ($0 as? ShimmerView)?.tag == -1 })
            shimmerViews.removeFromSuperview()
            view.didRemoveShimmerView(view)
        }
        self.replaceTableViewShimmerDataSource(subviews)
        self.replaceCollectionViewShimmerDataSource(subviews)
    }
}
