//
//  UIView+Shimmer.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/24/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

fileprivate var tableViewShimmerDataSources = [ObjectIdentifier: TableViewShimmerDataSource]()
fileprivate var collectionViewShimmerDataSources = [ObjectIdentifier: CollectionViewShimmerDataSource]()

fileprivate extension UIView {
    
    static var shimmer = "shimmer"
    
    func replaceTableViewOriginalDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UITableView }).map({ $0 as? UITableView }).forEach({
            if let tableView = $0, let originalDataSource = tableView.dataSource as? UITableViewShimmerDataSource {
                let shimmerDataSource = TableViewShimmerDataSource()
                shimmerDataSource.shimmerDataSource = originalDataSource
                tableViewShimmerDataSources[ObjectIdentifier(tableView)] = shimmerDataSource
                tableView.dataSource = shimmerDataSource
                tableView.reloadData()
            }
        })
    }
    
    func replaceCollectionViewOriginalDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UICollectionView }).map({ $0 as? UICollectionView }).forEach({
            if let collectionView = $0, let originalDataSource = collectionView.dataSource as? UICollectionViewShimmerDataSource {
                let shimmerDataSource = CollectionViewShimmerDataSource()
                shimmerDataSource.shimmerDataSource = originalDataSource
                collectionViewShimmerDataSources[ObjectIdentifier(collectionView)] = shimmerDataSource
                collectionView.dataSource = shimmerDataSource
                collectionView.reloadData()
            }
        })
    }
    
    func replaceTableViewShimmerDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UITableView }).map({ $0 as? UITableView }).forEach({
            if let tableView = $0, let shimmerDataSource = tableView.dataSource as? TableViewShimmerDataSource {
                tableView.dataSource = shimmerDataSource.shimmerDataSource
                tableViewShimmerDataSources.removeValue(forKey: ObjectIdentifier(tableView))
                tableView.reloadData()
            }
        })
    }
    
    func replaceCollectionViewShimmerDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UICollectionView }).map({ $0 as? UICollectionView }).forEach({
            if let collectionView = $0, let shimmerDataSource = collectionView.dataSource as? CollectionViewShimmerDataSource {
                collectionView.dataSource = shimmerDataSource.shimmerDataSource
                collectionViewShimmerDataSources.removeValue(forKey: ObjectIdentifier(collectionView))
                collectionView.reloadData()
            }
        })
    }
    
    func addShimmerView(to shimmerView: UIView, with properties: ShimmerProperties) {
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
    
    func getSubViewsForShimmer(_ allSubviews: [UIView]) -> [UIView] {
        var allSubviews = allSubviews
        allSubviews.append(self)
        return allSubviews.filter({ $0.isShimmering })
    }
    
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}

public extension UIView {
    
    @IBInspectable var isShimmering: Bool {
        get { return objc_getAssociatedObject(self, &UIView.shimmer) as? Bool ?? false }
        set { objc_setAssociatedObject(self, &UIView.shimmer, newValue, AssociationPolicy.retainNonatomic.objc) }
    }
    
    func showShimmerEffect(properties: ShimmerProperties = ShimmerProperties()) {
        DispatchQueue.main.async {
            let subviews = self.subviewsRecursive()
            self.replaceTableViewOriginalDataSource(subviews)
            self.replaceCollectionViewOriginalDataSource(subviews)
            let shimmerViews = self.getSubViewsForShimmer(subviews)
            for shimmerView in shimmerViews {
                shimmerView.addShimmerView(to: shimmerView, with: properties)
                shimmerView.didAddShimmerView(shimmerView)
            }
        }
    }
    
    @objc func didRemoveShimmerView(_ shimmerView: UIView) {}
    
    @objc func didAddShimmerView(_ shimmerView: UIView) {}
    
    func hideShimmerEffect() {
        DispatchQueue.main.async {
            let subviews = self.subviewsRecursive()
            let shimmerViews = self.getSubViewsForShimmer(subviews)
            for shimmerView in shimmerViews {
                guard let view = shimmerView.viewWithTag(-1) as? ShimmerView else { continue }
                view.removeFromSuperview()
                shimmerView.didRemoveShimmerView(shimmerView)
            }
            self.replaceTableViewShimmerDataSource(subviews)
            self.replaceCollectionViewShimmerDataSource(subviews)
        }
    }
}
