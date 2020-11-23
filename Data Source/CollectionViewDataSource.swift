//
//  CollectionViewDataSource.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 10/21/20.
//

import UIKit

internal class CollectionViewShimmerDataSource: NSObject, UICollectionViewDataSource {
    weak var originalDataSource: UICollectionViewShimmerDataSource?
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return originalDataSource!.numberOfShimmerSections(in: collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return originalDataSource!.shimmerCollectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = originalDataSource!.shimmerCollectionView(collectionView, cellForItemAt: indexPath)
        (cell as? PrepareForShimmer)?.prepareForShimmer()
        cell.showShimmerEffect()
        return cell
    }
}

