//
//  UIView+Shimmer.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/24/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

enum AssociationPolicy: UInt {
    case assign = 0
    case copy = 771
    case copyNonatomic = 3
    case retain = 769
    case retainNonatomic = 1
    
    var objc: objc_AssociationPolicy {
        return objc_AssociationPolicy(rawValue: rawValue)!
    }
}

fileprivate var tableViewShimmerDataSources = [ObjectIdentifier: TableViewShimmerDataSource]()

extension UIView {
    
    private static var shimmer = "shimmer"
    
    @IBInspectable var isShimmering: Bool {
        get { return objc_getAssociatedObject(self, &UIView.shimmer) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &UIView.shimmer, newValue, AssociationPolicy.retainNonatomic.objc) }
    }
    
    final func showShimmerEffect(properties: ShimmerProperties = ShimmerProperties()) {
        DispatchQueue.main.async {
            let subviews = self.subviewsRecursive()
            self.replaceTableViewOriginalDataSource(subviews)
            let shimmerViews = self.getSubViewsForShimmer(subviews)
            for shimmerView in shimmerViews {
                shimmerView.addShimmerView(to: shimmerView, with: properties)
                shimmerView.didAddShimmerView(shimmerView)
            }
        }
    }
    
    private func replaceTableViewOriginalDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UITableView }).map({ $0 as? UITableView }).forEach({
            if let tableView = $0, let originalDataSource = tableView.dataSource as? UITableViewShimmerDataSource {
                let shimmerDataSource = TableViewShimmerDataSource()
                shimmerDataSource.originalDataSource = originalDataSource
                tableViewShimmerDataSources[ObjectIdentifier(tableView)] = shimmerDataSource
                tableView.dataSource = shimmerDataSource
                tableView.reloadData()
            }
        })
    }
    
    private func replaceTableViewShimmerDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UITableView }).map({ $0 as? UITableView }).forEach({
            if let tableView = $0, let shimmerDataSource = tableView.dataSource as? TableViewShimmerDataSource {
                tableView.dataSource = shimmerDataSource.originalDataSource
                tableViewShimmerDataSources.removeValue(forKey: ObjectIdentifier(tableView))
                tableView.reloadData()
            }
        })
    }
    
    final func addShimmerView(to shimmerView: UIView, with properties: ShimmerProperties) {
        let view = ShimmerView(frame: shimmerView.bounds, properties: properties)
        view.tag = -1
        shimmerView.addSubview(view)
        shimmerView.bringSubviewToFront(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: shimmerView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: shimmerView.trailingAnchor).isActive = true
        view.topAnchor.constraint(equalTo: shimmerView.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: shimmerView.bottomAnchor).isActive = true
        self.layoutSubviews()
    }
    
    @objc func didRemoveShimmerView(_ shimmerView: UIView) {}
    
    @objc func didAddShimmerView(_ shimmerView: UIView) {}
    
    final func hideShimmerEffect() {
        DispatchQueue.main.async {
            let subviews = self.subviewsRecursive()
            self.replaceTableViewShimmerDataSource(subviews)
            let shimmerViews = self.getSubViewsForShimmer(subviews)
            for shimmerView in shimmerViews {
                guard let view = shimmerView.viewWithTag(-1) as? ShimmerView else { continue }
                view.removeFromSuperview()
                shimmerView.didRemoveShimmerView(shimmerView)
            }
        }
    }
    
    private func getSubViewsForShimmer(_ allSubviews: [UIView]) -> [UIView] {
        var allSubviews = allSubviews
        allSubviews.append(self)
        return allSubviews.filter({ $0.isShimmering })
    }
    
    private func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}
