//
//  RepositoriesCollectionView.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 15/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

/*
 Commmon code for CollectionViews displaying RepositoryCollectionCell
 
 (UICollectionViewDataSource & UICollectionViewDelegate need to be implemented
 in the class which owned the CollectionView
 */
class RepositoriesCollectionView: UICollectionView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        registerNibs()
        setupLayout()
    }
    
    private func registerNibs() {
        RepositoryCollectionCell.register(in: self)
    }
    
    private func setupLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        flowLayout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
        flowLayout.sectionInset = UIEdgeInsets(
            top: Constants.Metrics.margin,
            left: Constants.Metrics.margin,
            bottom: Constants.Metrics.margin,
            right: Constants.Metrics.margin
        )
        collectionViewLayout = flowLayout
    }
}
