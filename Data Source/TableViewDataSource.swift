//
//  TableViewDataSource.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 10/21/20.
//

import UIKit

internal class TableViewShimmerDataSource: NSObject, UITableViewDataSource {
    weak var originalDataSource: UITableViewShimmerDataSource?
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return originalDataSource!.shimmerTableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = originalDataSource!.shimmerTableView(tableView, cellForRowAt: indexPath)
        (cell as? PrepareForShimmer)?.prepareForShimmer()
        cell.showShimmerEffect()
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return originalDataSource!.numberOfShimmerSections(in: tableView)
    }
}
