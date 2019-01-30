//
//  RemoveRepositoryConfirmationView.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 16/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

class RemoveRepositoryConfirmationView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var removeButtonBottomConstraint: NSLayoutConstraint!
    
    var removeCompletion: ()->() = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(Constants.Xib.removeRepositoryConfirmationView, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        initialViewsSetup()
    }
    
    private func initialViewsSetup() {
        contentView.alpha = 0.0
        removeButtonBottomConstraint.constant = -removeButton.bounds.height
        isHidden = true
        layoutIfNeeded()
    }
}

extension RemoveRepositoryConfirmationView {
    func appear() {
        isHidden = false
        removeButtonBottomConstraint.constant = 8
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.alpha = 1.0
            self.layoutIfNeeded()
        })
    }
    
    func disappear() {
        removeButtonBottomConstraint.constant = -removeButton.bounds.height
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.alpha = 0.0
            self.layoutIfNeeded()
        }) { _ in
            self.isHidden = true
        }
    }
}

extension RemoveRepositoryConfirmationView {
    
    @IBAction func removeAction() {
        removeCompletion()
        disappear()
    }
    
    @IBAction func dismissAction() {
        disappear()
    }
}
