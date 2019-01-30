//
//  AddRepositoryViewModel.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 16/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation
import Alamofire

class AddRepositoryViewModel {
    
    var repositories: [Repository] = []
    
    var urlString: String = ""
    var numberPerPage: Int = 20
    var isFirstTimeLoading: Bool = false
    var totalCount: Int = 0
    
    func searchRepositories(query: String = "", success: @escaping ()->(), error: @escaping ()->()) {
        
        if isFirstTimeLoading {
            let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? " "
            urlString = "\(Constants.Api.searchRepositories)?per_page=\(numberPerPage)&q=\(encodedQuery)"
            isFirstTimeLoading = false
        }
        
        
        WebService.searchRepositories(urlString: urlString, success: { (json, link) in
            self.urlString = link.extractNextLink()
            print("[LOG] > Next URL: \(self.urlString)")
            var items: [Repository] = []
            for itemJson in json["items"].arrayValue {
                items.append(Repository(json: itemJson))
            }
            self.repositories.append(contentsOf: items)
            self.totalCount = json["total_count"].intValue
            success()
        }) {
            error()
        }
    }
    
    func resetSearch() {
        isFirstTimeLoading = true
        repositories.removeAll()
        totalCount = 0
    }
    
    func isTotalCountReached() -> Bool {
        return repositories.count < totalCount
    }
}
