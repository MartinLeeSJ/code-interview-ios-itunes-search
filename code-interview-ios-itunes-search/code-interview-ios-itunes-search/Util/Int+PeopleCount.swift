//
//  Int+PeopleCount.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/28.
//

import Foundation

extension Int {
    func peopleCountString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        
        let absNumber = abs(self)
        switch absNumber {
        case 10_000...:
            formatter.positiveSuffix = "만"
            return formatter.string(from: NSNumber(value: self / 10_000)) ?? ""
        case 1_000..<10_000:
            formatter.positiveSuffix = "천"
            return formatter.string(from: NSNumber(value: self / 1_000)) ?? ""
        default:
            return formatter.string(from: NSNumber(value: self)) ?? ""
        }
    }
}
