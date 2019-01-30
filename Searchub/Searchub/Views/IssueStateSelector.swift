//
//  IssueStateSelector.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 17/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

protocol IssueStateSelectorDelegate {
    func allSelected()
    func openSelected()
    func closedSelected()
}

class IssueStateSelector: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    /*
     Only one of those three constraints can be active at the same time.
     /!\ DO NOT ACTIVE TWO OR MORE AT THE SAME TIME
     */
    @IBOutlet weak var dummyViewButtonHorizontalCentersConstraint: NSLayoutConstraint!
    
    var delegate: IssueStateSelectorDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(Constants.Xib.issueStateSelector, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func allSelection() {
        animateToAll()
        delegate?.allSelected()
    }
    
    @IBAction func openSelection() {
        animateToOpen()
        delegate?.openSelected()
    }
    
    @IBAction func closedSelection() {
        animateToClose()
        delegate?.closedSelected()
    }
    
    /*
     The 3 following methods should be the only ones which use the three center constrains
     The one associated to the button touched should be actived AFTER the other twos are disabled
     in order to prevent any Constraints Error in the Console Logs
     */
    private func animateToClose() {
//        dummyViewOpenHorizontalCentersConstraint.isActive = false
//        dummyViewAllHorizontalCentersConstraint.isActive = false
//        dummyViewClosedHorizontalCentersConstraint.isActive = true
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    private func animateToOpen() {
//        dummyViewClosedHorizontalCentersConstraint.isActive = false
//        dummyViewAllHorizontalCentersConstraint.isActive = false
//        dummyViewOpenHorizontalCentersConstraint.isActive = true
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    private func animateToAll() {
//        dummyViewClosedHorizontalCentersConstraint.isActive = false
//        dummyViewOpenHorizontalCentersConstraint.isActive = false
//        dummyViewAllHorizontalCentersConstraint.isActive = true
        UIView.animate(withDuration: 0.1, animations: {
            self.layoutIfNeeded()
        })
    }
    
    /*******************************/
    
    /*
     This method is used to get a view with the maximum width
     */
    override var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
    } 
}
