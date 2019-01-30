//
//  String+NextLinkExtraction.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 17/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation

/*
 Parsing method that extract a next link from Github's api reponse headers
 */
extension String {
    func extractNextLink() -> String {
        let components = self.components(separatedBy: ",")
        var next = ""
        for component in components {
            if component.contains("rel=\"next\"") {
                next = component
            }
        }
        if let match = next.range(of: "(?<=<)[^>]+", options: .regularExpression) {
            return String(next[match])
        }
        return ""
    }
}
