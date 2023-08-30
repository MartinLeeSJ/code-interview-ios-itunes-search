//
//  SearchView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isSubmitted {
                    SearchResultView(viewModel: viewModel)
                } else {
                    SearchHistoryView(viewModel: viewModel)
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
