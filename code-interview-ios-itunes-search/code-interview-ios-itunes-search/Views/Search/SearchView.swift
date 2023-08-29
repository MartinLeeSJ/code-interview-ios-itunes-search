//
//  SearchView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isSubmitted {
                    SearchResultView(viewModel: viewModel)
                } else {
                    searchHistory
                }
            }
            .padding()
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
        List {
            HStack {
                Text("최근 검색어")
                    .font(.title2.bold())
                Spacer()
                Button {
                    viewModel.deleteSearchHistory()
                } label: {
                    Text("기록 삭제")
                        .foregroundColor(.blue)
                }
            }
            .listRowInsets(historyListRowInsets)
            .listRowSeparator(.hidden)
            
            ForEach(viewModel.searchHistory, id: \.self) { history in
                Button {
                    viewModel.setSearchQuery(history)
                    viewModel.setSubmit(to: true)
                } label: {
                    Text(history)
                        .font(.title3)
                        .foregroundColor(.blue)
                }
                .listRowInsets(historyListRowInsets)
            }
        }
        .listStyle(.plain)
    }
}

//MARK: - 검색제안
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
