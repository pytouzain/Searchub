//
//  Issue.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 15/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

enum IssueState: String {
    case all
    case open
    case closed
    case none
    
    func pastParticiple() -> String {
        switch self {
        case .open:
            return "opened"
        case .closed:
            return "closed"
        default:
            return ""
        }
    }
}

struct Issue {
    var title: String
    var number: Int
    var state: IssueState
    var createdAt: String
    var closedAt: String
    var numberComments: Int
    var commentsUrlString: String
    var body: String
    var user: User
    
    init(json: JSON) {
        title = json["title"].stringValue
        number = json["number"].intValue
        state = IssueState(rawValue: json["state"].stringValue) ?? .none
        createdAt = json["created_at"].stringValue
        closedAt = json["closed_at"].stringValue
        numberComments = json["comments"].intValue
        commentsUrlString = json["comments_url"].stringValue
        body = json["body"].stringValue
        user = User(json: json["user"])
    }
}
