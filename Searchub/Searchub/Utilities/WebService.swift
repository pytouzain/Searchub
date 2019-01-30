//
//  WebService.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 14/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct WebService {
    static func searchRepositories(urlString: String, success: @escaping (JSON, String)->(), error: @escaping ()->()) {
        print("[LOG] > Search Repositories URL: \(urlString)")
        Alamofire.request(
            urlString,
            method: .get
        ).responseData { (response) in
            switch response.result {
            case .success(let value):
                print("[SUCCESS] > Search Repositories")
                let json = JSON(value)
                
                /*
                 Link contains raw datas, potentially including a "next" link, and need to be parsed
                 Use 'extractNextLink()' method from String class
                */
                let link = response.response?.allHeaderFields["Link"] as? String ?? ""
                
                success(json, link)
            case.failure(let err):
                print("[ERROR] > Search Repositories: \(err.localizedDescription)")
                error()
            }
        }
    }
    
    static func searchIssues(urlString: String, success: @escaping (JSON, String)->(), error: @escaping ()->()) {
        print("[LOG] > Search Issues URL: \(urlString)")
        Alamofire.request(
            urlString,
            method: .get
            ).responseData { (response) in
                switch response.result {
                case .success(let value):
                    print("[SUCCESS] > Search Issues")
                    let json = JSON(value)
                    
                    /*
                     Link contains raw datas, potentially including a "next" link, and needs to be parsed
                     Use 'extractNextLink()' method from 'String' class
                     */
                    let link = response.response?.allHeaderFields["Link"] as? String ?? ""
                    
                    success(json, link)
                case.failure(let err):
                    print("[ERROR] > Search Issues: \(err.localizedDescription)")
                    error()
                }
        }
    }
    
    static func searchComments(urlString: String, success: @escaping (JSON, String)->(), error: @escaping ()->()) {
        print("[LOG] > Search Comments URL: \(urlString)")
        Alamofire.request(
            urlString,
            method: .get
            ).responseData { (response) in
                switch response.result {
                case .success(let value):
                    print("[SUCCESS] > Search Comments")
                    let json = JSON(value)
                    
                    /*
                     Link contains raw datas, potentially including a "next" link, and need to be parsed
                     Use 'extractNextLink()' method from String class
                     */
                    let link = response.response?.allHeaderFields["Link"] as? String ?? ""
                    
                    success(json, link)
                case.failure(let err):
                    print("[ERROR] > Search Comments: \(err.localizedDescription)")
                    error()
                }
        }
    }
}
