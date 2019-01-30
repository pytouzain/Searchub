//
//  IssueCell.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 17/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

class IssueCell: UITableViewCell, Registrable, Dequeable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numberCommentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(issue: Issue) {
        titleLabel.text = issue.title
        buildDescriptionLabel(fromIssue: issue)
        numberCommentsLabel.text = "\(issue.numberComments)"
    }
    
    private func buildDescriptionLabel(fromIssue issue: Issue) {
        let stateString = issue.state.pastParticiple()
        var descriptionText: String = ""
        
        switch issue.state {
        case .open:
            let creationDate = issue.createdAt.formatDate(
                from: Constants.Date.inputFormat,
                to: Constants.Date.outputFormat
            )
            descriptionText = "#\(issue.number) \(stateString) on \(creationDate) by \(issue.user.login)"
        case .closed:
            let closingDate = issue.closedAt.formatDate(
                from: Constants.Date.inputFormat,
                to: Constants.Date.outputFormat
            )
            descriptionText = "#\(issue.number) by \(issue.user.login) was \(stateString) on \(closingDate)"
        default:
            descriptionText = ""
        }
        descriptionLabel.text = descriptionText
    }
 }
