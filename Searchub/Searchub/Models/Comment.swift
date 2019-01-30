//
//  Comment.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 18/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Comment {
    var htmlUrlString: String
    var body: String
    var user: User
    
    init(json: JSON) {
        htmlUrlString = json["html_url"].stringValue
        user = User(json: json["user"])
        body = json["body"].stringValue
    }
}
