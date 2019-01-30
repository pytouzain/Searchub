//
//  UICollectionViewCell+SizeFitting.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 19/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation

extension UICollectionViewCell {
    /// This is a workaround method for self sizing collection view cells which stopped working for iOS 12
    func setupSelfSizingForiOS12(contentView: UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}
