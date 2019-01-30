//
//  Registrable.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 17/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation

/*
 Usage: MyBeautifulCell.register(in: [tableView/collectionView])
 */
protocol Registrable {}

extension Registrable where Self:UITableViewCell {
    static func register(in tableView: UITableView) {
        tableView.register(
            UINib(nibName: String(describing: Self.self), bundle: nil),
            forCellReuseIdentifier: String(describing: Self.self)
        )
    }
}

extension Registrable where Self:UICollectionViewCell {
    static func register(in collectionView: UICollectionView) {
        collectionView.register(
            UINib(nibName: String(describing: Self.self), bundle: nil),
            forCellWithReuseIdentifier: String(describing: Self.self)
        )
    }
}
