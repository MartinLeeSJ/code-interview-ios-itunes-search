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
    
    @Published var searchHistory: [String] = UserDefaults.searchHistory
    @Published var searchSuggestions: [String] = []
    
    @Published var isLoaded: Bool = false
    @Published var isSubmitted: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init() {
        $searchQuery
            .sink { [weak self] query in
                self?.setIsSubmitted(to: false)
                self?.filterSearchSuggestions(query: query)
            }
            .store(in: &cancellables)
        
        $isSubmitted
            .removeDuplicates()
            .sink { [weak self] submitted in
                guard let self else { return }
                guard submitted else { return }
                guard !self.searchQuery.isEmpty else { return }
                
                self.memorizeSearchQuery(self.searchQuery)
                self.fetchSearchResult(query: self.searchQuery)
            }
            .store(in: &cancellables)
    }
    
    func setIsSubmitted(to bool: Bool) {
        isSubmitted = bool
    }
    
    private func setIsLoaded(to bool: Bool) {
        isLoaded = bool
    }
    
    func setSearchQuery(_ string: String) {
        searchQuery = string
    }
    
    func deleteSearchHistory() {
        UserDefaults.deleteSearchHistory()
        setSearchHistory()
    }
    
    private func memorizeSearchQuery(_ string: String) {
        UserDefaults.memorizeSearchHistroy(string)
        setSearchHistory()
    }
    
    private func setSearchHistory() {
        searchHistory = UserDefaults.searchHistory
    }
    
    private func filterSearchSuggestions(query: String) {
        searchSuggestions = searchHistory.filter { $0.localizedCaseInsensitiveContains(query)}
    }
    
    private func fetchSearchResult(query: String) {
        setIsLoaded(to: false)
        searchResults.removeAll()
        
        guard !query.isEmpty else {
            self.setIsSubmitted(to: false)
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
            self?.setIsLoaded(to: true)
        }
    }
    
}
