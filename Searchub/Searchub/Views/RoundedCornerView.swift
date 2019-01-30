//
//  RoundedCornerView.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 16/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

@IBDesignable class RoundedCornerView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 1 {
        didSet{
            setNeedsLayout()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
    }
}
