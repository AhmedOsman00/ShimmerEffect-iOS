//
//  TableViewDataSource.swift
//  FBSnapshotTestCase
//
//  Created by Ahmed Osman on 10/21/20.
//

import UIKit

public class TableViewShimmerDataSource: NSObject, UITableViewDataSource {
    weak var shimmerDataSource: UITableViewShimmerDataSource?
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shimmerDataSource!.shimmerTableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shimmerDataSource!.shimmerTableView(tableView, cellForRowAt: indexPath)
        (cell as? PrepareForShimmer)?.prepareForShimmer()
        cell.showShimmerEffect()
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return shimmerDataSource!.numberOfShimmerSections(in: tableView)
    }
}
