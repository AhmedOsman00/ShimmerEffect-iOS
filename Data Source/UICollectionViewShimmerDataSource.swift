//
//  UICollectionViewShimmerDataSource.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 10/21/20.
//

import UIKit

public protocol UICollectionViewShimmerDataSource: UICollectionViewDataSource {
    func shimmerCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func shimmerCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func numberOfShimmerSections(in collectionView: UICollectionView) -> Int
}

public extension UICollectionViewShimmerDataSource {
    
    func shimmerCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionView(collectionView, numberOfItemsInSection: section)
    }
    
    func shimmerCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.collectionView(collectionView, cellForItemAt: indexPath)
    }
    
    func numberOfShimmerSections(in collectionView: UICollectionView) -> Int {
        return self.numberOfSections?(in: collectionView) ?? 1
    }
}
