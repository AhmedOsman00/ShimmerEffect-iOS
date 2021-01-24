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
        if let number = originalDataSource?.shimmerTableView(tableView, numberOfRowsInSection: section) {
            return number
        }else{
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = originalDataSource?.shimmerTableView(tableView, cellForRowAt: indexPath) else{
            return UITableViewCell()
        }
        (cell as? PrepareForShimmer)?.prepareForShimmer()
        cell.showShimmerEffect()
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let number = originalDataSource?.numberOfShimmerSections(in: tableView) {
            return number
        }else{
            return 0
        }
    }
}
