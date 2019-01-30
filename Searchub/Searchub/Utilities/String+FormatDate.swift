//
//  String+FormatDate.swift
//  Searchub
//
//  Created by Pierre-Yves Touzain on 17/01/2019.
//  Copyright © 2019 TYP Studio. All rights reserved.
//

import Foundation

extension String {
    func formatDate(from inputFormat: String, to outputFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        
        //let dateFormatterPrint = DateFormatter()
        
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        } else {
            print("[ERROR] > Date format failed for string [\(self)]")
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: Date())
        }
    }
}
