//
//  User.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 15/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation
import Realm
import RealmSwift
import SwiftyJSON

@objc class User: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var login: String = ""
    @objc dynamic var avatarUrlString: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init(json: JSON) {
        self.init()
        id = json["id"].intValue
        login = json["login"].stringValue
        avatarUrlString = json["avatar_url"].stringValue
    }
}
