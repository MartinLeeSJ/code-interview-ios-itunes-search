//
//  UserDefaults+SearchHistory.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/30.
//

import Foundation

extension UserDefaults {
    private struct HistoryKey {
        static let name: String = "history"
        static let maxCount: Int = 20
    }
    
    static var searchHistory: [String] {
        get {
            UserDefaults.standard.stringArray(forKey: HistoryKey.name) ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: HistoryKey.name)
        }
    }
    
    static func memorizeSearchHistroy(_ newValue: String) {
        let history: [String] = Self.searchHistory
        
        var setLength: Int = min(history.count, HistoryKey.maxCount - 1)
        setLength = max(0, setLength)
        
        var historySet: Set<String> = Set(history.prefix(upTo: setLength))
        
        historySet.insert(newValue)
        
        Self.searchHistory = Array(historySet)
    }
    
    static func deleteSearchHistory() {
        UserDefaults.searchHistory = []
    }
}
