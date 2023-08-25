//
//  String+DateFormat.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/25.
//

import Foundation

extension String {
    func covertToIso8601Date() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        
        return dateFormatter.date(from: self)
    }
}
