//
//  Constants.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 18/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation

struct Constants {
    struct Metrics {
        static let margin: CGFloat = 16
    }
    
    struct Date {
        static let inputFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        static let outputFormat = "d MMM yyyy"
    }
    
    struct Xib {
        static let removeRepositoryConfirmationView = "RemoveRepositoryConfirmationView"
        static let issueStateSelector = "IssueStateSelector"
        static let loadStatusView = "LoadStatusView"
    }
    
    struct Api {
        static let baseApi = "https://api.github.com"
        static let searchRepositories = "\(baseApi)/search/repositories"
    }
    
    struct Refresh {
        static let verticalOffset: CGFloat = 80
    }
}
