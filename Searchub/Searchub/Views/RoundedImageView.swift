//
//  RoundedImageView.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 16/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

@IBDesignable class RoundedImageView: UIImageView {

    @IBInspectable var borderWidth: CGFloat = 2 {
        didSet{
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet{
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true
    }
}
