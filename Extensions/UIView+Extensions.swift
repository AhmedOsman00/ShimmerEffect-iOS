//
//  UIView+Extensions.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 22/11/2020.
//

import UIKit

fileprivate var tableViewShimmerDataSources = [ObjectIdentifier: TableViewShimmerDataSource]()
fileprivate var collectionViewShimmerDataSources = [ObjectIdentifier: CollectionViewShimmerDataSource]()

internal extension UIView {
    
    static var shimmer = "shimmer"
    
    func replaceTableViewOriginalDataSource(_ subviews: [UIView]) {
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
    
    func replaceCollectionViewOriginalDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UICollectionView }).map({ $0 as? UICollectionView }).forEach({
            if let collectionView = $0, let originalDataSource = collectionView.dataSource as? UICollectionViewShimmerDataSource {
                let shimmerDataSource = CollectionViewShimmerDataSource()
                shimmerDataSource.originalDataSource = originalDataSource
                collectionViewShimmerDataSources[ObjectIdentifier(collectionView)] = shimmerDataSource
                collectionView.dataSource = shimmerDataSource
                collectionView.reloadData()
            }
        })
    }
    
    func replaceTableViewShimmerDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UITableView }).map({ $0 as? UITableView }).forEach({
            if let tableView = $0, let shimmerDataSource = tableView.dataSource as? TableViewShimmerDataSource {
                tableView.dataSource = shimmerDataSource.originalDataSource
                tableViewShimmerDataSources.removeValue(forKey: ObjectIdentifier(tableView))
                tableView.reloadData()
            }
        })
    }
    
    func replaceCollectionViewShimmerDataSource(_ subviews: [UIView]) {
        subviews.lazy.filter({ $0 is UICollectionView }).map({ $0 as? UICollectionView }).forEach({
            if let collectionView = $0, let shimmerDataSource = collectionView.dataSource as? CollectionViewShimmerDataSource {
                collectionView.dataSource = shimmerDataSource.originalDataSource
                collectionViewShimmerDataSources.removeValue(forKey: ObjectIdentifier(collectionView))
                collectionView.reloadData()
            }
        })
    }
    
    @objc func addShimmerView(to shimmerView: UIView, with properties: ShimmerProperties) {
        let view = ShimmerView(frame: shimmerView.bounds, properties: properties)
        view.tag = -1
        shimmerView.addSubview(view)
        shimmerView.bringSubviewToFront(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.pinTo(view: shimmerView)
        shimmerView.layoutSubviews()
    }
    
    func pinTo(view: UIView) {
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
