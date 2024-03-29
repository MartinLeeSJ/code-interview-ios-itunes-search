//
//  SearchView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.colorScheme) var scheme
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isSubmitted {
                    SearchResultView(viewModel: viewModel)
                } else {
                    SearchHistoryList(viewModel: viewModel)
                }
            }
            .padding()
            .navigationTitle("검색")
            .searchable(text: $viewModel.searchQuery, prompt: "App Store")
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .searchSuggestions(searchSuggestionList)
            .onSubmit(of: .search) {
                viewModel.setIsSubmitted(to: true)
            }
            
        }
       
    }
}

//MARK: - 검색제안
extension SearchView {
    @ViewBuilder
    func searchSuggestionList() -> some View {
        if !viewModel.isSubmitted {
            ForEach(viewModel.searchSuggestions, id: \.self) { suggestion in
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    Text(suggestion)
                        .foregroundColor(scheme == .light ? .black : .white)
                }
                .searchCompletion(suggestion)
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
