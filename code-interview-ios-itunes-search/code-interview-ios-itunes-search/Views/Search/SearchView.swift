//
//  SearchView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.isSubmitted {
                    searchResults
                } else {
                    searchHistory
                }
            }
            .padding()
            .listStyle(.plain)
            .navigationTitle("검색")
            .searchable(text: $viewModel.searchQuery, prompt: "App Store")
            .searchSuggestions(searchSuggestionList)
            .onSubmit(of: .search) {
                viewModel.setSubmit(to: true)
            }
        }
       
    }
}

//MARK: - 검색기록
extension SearchView {
    private var historyListRowInsets: EdgeInsets {
        EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    }
    
    @ViewBuilder
    var searchHistory: some View {
        HStack {
            Text("최근 검색어")
                .font(.title2.bold())
            Spacer()
            Button("기록 삭제") {
                viewModel.deleteSearchHistory()
            }
            .tint(.blue)
        }
        .listRowInsets(historyListRowInsets)
        .listRowSeparator(.hidden)
        
        ForEach(viewModel.searchHistory, id: \.self) { history in
            Button(history, action: {
                viewModel.setSearchQuery(history)
                viewModel.setSubmit(to: true)
            })
            .listRowInsets(historyListRowInsets)
        }
    }
}

//MARK: - 검색결과
extension SearchView {
    private var resultListRowInsets: EdgeInsets {
        EdgeInsets(top: .spacing(multiplier: 2), leading: 0, bottom: .spacing(multiplier: 2), trailing: 0)
    }
    
    @ViewBuilder
    var searchResults: some View {
        ForEach(viewModel.searchResults, id: \.self) { app in
            SearchResultCell(app: app)
                .listRowInsets(resultListRowInsets)
                .listRowSeparator(.hidden)
        }
    }
}

extension SearchView {
    @ViewBuilder
    func searchSuggestionList() -> some View {
        if !viewModel.isSubmitted {
            ForEach(viewModel.searchResults, id: \.self) { app in
                Label(app.title, systemImage: "magnifyingglass")
                    .foregroundColor(.secondary)
                    .searchCompletion(app.title)
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
