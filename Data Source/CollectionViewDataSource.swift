//
//  CollectionViewDataSource.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 10/21/20.
//

import UIKit

public class CollectionViewShimmerDataSource: NSObject, UICollectionViewDataSource {
    weak var shimmerDataSource: UICollectionViewShimmerDataSource?
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return shimmerDataSource!.numberOfShimmerSections(in: collectionView)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shimmerDataSource!.shimmerCollectionView(collectionView, numberOfItemsInSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = shimmerDataSource!.shimmerCollectionView(collectionView, cellForItemAt: indexPath)
        (cell as? PrepareForShimmer)?.prepareForShimmer()
        cell.showShimmerEffect()
        return cell
    }
}

