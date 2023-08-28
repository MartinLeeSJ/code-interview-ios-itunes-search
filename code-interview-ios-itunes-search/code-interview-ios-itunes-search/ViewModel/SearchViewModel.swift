//
//  SearchViewModel.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/25.
//

import Foundation
import Combine
import Alamofire

final class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var searchResults: [Application] = []
    @Published var searchHistory: [String] = []
    @Published var isSubmitted: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let historyKey = "history"
    private let maxHistoryCount: Int = 10
    
    init() {
        self.searchHistory = UserDefaults.standard.stringArray(forKey: historyKey) ?? []
        
        $searchQuery
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchResults.removeAll()
                self?.fetchSearchResult(query: query)
            }
            .store(in: &cancellables)
        
        $isSubmitted
            .sink { [weak self] submitted in
                guard let self else { return }
                guard submitted else { return }
                guard !self.searchQuery.isEmpty else { return }
                
                self.memorizeSearchQuery(self.searchQuery)
            }
            .store(in: &cancellables)
    }
    
    func setSubmit(to bool: Bool) {
        isSubmitted = bool
    }
    
    func setSearchQuery(_ string: String) {
        searchQuery = string
    }
    
    func deleteSearchHistory() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(Array<String>(), forKey: historyKey)
        searchHistory = userDefaults.stringArray(forKey: historyKey) ?? []
    }
    
    private func memorizeSearchQuery(_ string: String) {
        let userDefaults = UserDefaults.standard
        
        if let histroy = userDefaults.stringArray(forKey: historyKey) {
            var historySet: Set<String> = Set(histroy)
            
            historySet = Set(historySet.prefix(maxHistoryCount - 1))
            historySet.insert(string)
            
            userDefaults.set(Array(historySet), forKey: historyKey)
        } else {
            userDefaults.set([string], forKey: historyKey)
        }
        
        searchHistory = userDefaults.stringArray(forKey: historyKey) ?? []
    }
    
    private func fetchSearchResult(query: String) {
        guard !query.isEmpty else {
            setSubmit(to: false)
            return
        }
        
        let parameters = [
            "term" : query,
            "media" : "software",
            "limit" : "20",
            "country" : "KR"
        ]
        let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(spaceEncoding: .plusReplaced))
        
        AF.request(
            "https://itunes.apple.com/search",
            parameters: parameters,
            encoder: encoder)
        .responseDecodable(of: AppResponse.self) { [weak self] response in
            switch response.result {
            case .success(let results):
                self?.searchResults = results.applications
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
