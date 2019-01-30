//
//  Repository.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 14/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation
import SwiftyJSON
import Realm
import RealmSwift

class Repository: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var repoDescription: String = ""
    @objc dynamic var issuesUrlString: String = ""
    @objc dynamic var stargazersCount: Int = 0
    @objc dynamic var forksCount: Int = 0
    @objc dynamic var owner: User?
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init(json: JSON) {
        self.init()
        id = json["id"].intValue
        name = json["name"].stringValue
        repoDescription = json["description"].stringValue
        issuesUrlString = json["issues_url"].stringValue.replacingOccurrences(of: "{/number}", with: "")
        stargazersCount = json["stargazers_count"].intValue
        forksCount = json["forks_count"].intValue
        owner = User(json: json["owner"])
    }
}

