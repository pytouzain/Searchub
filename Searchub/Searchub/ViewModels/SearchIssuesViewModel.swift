//
//  SearchIssuesViewModel.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 17/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

class SearchIssuesViewModel {
    
    var repository: Repository?
    
    /*
     Contains ALL issues fetched with the first request when the user arrive on the view
     */
    var issues: [Issue] = [] {
        didSet {
            filteredIssues = issues
        }
    }
    
    /*
     Contains the issues with a title including the terms in the SearchBar, all states included
     */
    var searchedIssues: [Issue] = []
    
    /*
     Contains the issues displayed on screen. It needs to be fed by searchedIssues, or issues if
     the search is reset. After that, a final filter depending of state needs to be applied
     (see 'filterByState' in this class)
     */
    var filteredIssues: [Issue] = []
    
    var urlString: String = ""
    var numberPerPage: Int = 20
    
    var currentIssueState: IssueState = .all
    
    func initialUrlSetup() {
        urlString = "\(repository?.issuesUrlString ?? "")?per_page=\(numberPerPage)&state=all"
    }
    
    func searchIssues(success: @escaping ()->(), error: @escaping ()->()) {
        WebService.searchIssues(urlString: urlString, success: { (json, link) in
            self.urlString = link.extractNextLink()
            print("[LOG] > Next URL: \(self.urlString)")
            var items: [Issue] = []
            for itemJson in json.arrayValue {
                items.append(Issue(json: itemJson))
            }
            self.issues.append(contentsOf: items)
            self.searchedIssues = self.issues
            self.filterByState(self.currentIssueState)
            success()
        }) {
            error()
        }
    }
    
    func filterIssues(_ searchText: String, completion: ()->() = {}) {
        searchedIssues = issues.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        filterByState(currentIssueState)
        completion()
    }
    
    func resetSearch(comletion: ()->() = {}) {
        filteredIssues = issues
        searchedIssues = issues
        filterByState(currentIssueState)
        comletion()
    }
    
    func filterByState(_ state: IssueState, completion: ()->() = {}) {
        currentIssueState = state
        if state == .all {
            filteredIssues = searchedIssues
        } else {
            filteredIssues = searchedIssues.filter { $0.state == state }
        }
        completion()
    }
}
