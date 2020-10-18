//
//  ShimmerDataSources.swift
//  ShimmerEffect-iOS
//
//  Created by Ahmed Osman on 9/30/20.
//  Copyright © 2020 Ahmed Osman. All rights reserved.
//

import UIKit

protocol UITableViewShimmerDataSource: UITableViewDataSource {
    func numberOfShimmerSections(in tableView: UITableView) -> Int
    func shimmerTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func shimmerTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

extension UITableViewShimmerDataSource {
    func numberOfShimmerSections(in tableView: UITableView) -> Int {
        return 1
    }
}

class TableViewShimmerDataSource: NSObject, UITableViewDataSource {
    weak var originalDataSource: UITableViewShimmerDataSource?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return originalDataSource!.shimmerTableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return originalDataSource!.shimmerTableView(tableView, cellForRowAt: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return originalDataSource!.numberOfShimmerSections(in: tableView)
    }
}
