//
//  DataManager.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 15/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

struct DataManager {
    
    static let shared: DataManager = DataManager()
    
    let realm = try! Realm()
    
    func addRepository(_ repository: Repository) {
        try! realm.write {
            realm.add(repository, update: true)
        }
    }
    
    func getRepositoriesList() -> [Repository] {
        let repositories = realm.objects(Repository.self)
        return Array(repositories)
    }
    
    func deleteRepository(_ repository: Repository) {
        try! realm.write {
            realm.delete(repository)
        }
    }
}
