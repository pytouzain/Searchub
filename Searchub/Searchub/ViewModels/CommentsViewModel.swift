//
//  CommentsViewModel.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 18/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit

class CommentsViewModel {

    var contentHTMLString: String = ""
    var issue: Issue?
    
    /*
     Add html code here
    */
    func searchComments(success: @escaping ()->(), error: @escaping ()->()) {
        contentHTMLString += "<h1>@\(issue?.user.login ?? "")</h1>"
        contentHTMLString += issue?.body ?? ""
        contentHTMLString += "<br /><br />"
        contentHTMLString += "<hr/>"
        WebService.searchComments(urlString: issue?.commentsUrlString ?? "", success: { (json, link) in
            for (index, itemJson) in json.arrayValue.enumerated() {
                let comment = Comment(json: itemJson)
                self.contentHTMLString += "<h1>@\(comment.user.login)</h1>"
                self.contentHTMLString += comment.body
                self.contentHTMLString += "<br /><br />"
                if index < (json.arrayValue.count - 1) {
                    self.contentHTMLString += "<hr/>"
                }
            }
            success()
        }) {
            error()
        }
    }
    
    func getCommentsHTMLString() -> String {
        let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"></HEAD><BODY>"
        let htmlEnd = "</BODY></HTML>"
        return "\(htmlStart)\(contentHTMLString)\(htmlEnd)"
    }
}
