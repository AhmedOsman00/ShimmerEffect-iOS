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
        if let number = originalDataSource?.numberOfShimmerSections(in: collectionView) {
            return number
        }else{
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let number = originalDataSource?.shimmerCollectionView(collectionView, numberOfItemsInSection: section) {
            return number
        }else{
            return 0
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = originalDataSource?.shimmerCollectionView(collectionView, cellForItemAt: indexPath) else {
            return UICollectionViewCell()
        }
        (cell as? PrepareForShimmer)?.prepareForShimmer()
        cell.showShimmerEffect()
        return cell
    }
}

