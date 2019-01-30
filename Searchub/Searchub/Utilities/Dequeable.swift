//
//  Dequeable.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 17/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation

/*
 Usage: MyBeautifulCell.dequeue(from: [tableView/collectionView], for: indexPath)
 */
protocol Dequeable {}

extension Dequeable where Self:UITableViewCell {
    static func dequeue(from tableView: UITableView, for indexPath: IndexPath) -> Self {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: Self.self), for: indexPath) as! Self
    }
}

extension Dequeable where Self:UICollectionViewCell {
    static func dequeue(from collectionView: UICollectionView, for indexPath: IndexPath) -> Self {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Self.self), for: indexPath) as! Self
    }
}
