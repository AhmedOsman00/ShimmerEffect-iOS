//
//  ShimmerDataSources.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/30/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

public protocol UITableViewShimmerDataSource: UITableViewDataSource {
    func numberOfShimmerSections(in tableView: UITableView) -> Int
    func shimmerTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func shimmerTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

public extension UITableViewShimmerDataSource {
    func numberOfShimmerSections(in tableView: UITableView) -> Int {
        return self.numberOfSections?(in: tableView) ?? 1
    }
    
    func shimmerTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func shimmerTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        (cell as? PrepareForShimmer)?.prepareForShimmer()
        return cell
    }
}
