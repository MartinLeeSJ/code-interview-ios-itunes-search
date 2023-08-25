//
//  SearchView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewmodel = SearchViewModel()
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    @State private var query: String = ""
    @State private var isSubmitted: Bool = false
    private var searchList: [String] = ["녹음기", "엠넷", "pitu", "의지의 히어로", "구글맵", "진에어", "grab"]
    
    var body: some View {
        NavigationStack {
            List {
                if !viewmodel.isSubmitted {
                    HStack {
                        Text("최근 검색어")
                            .font(.title2.bold())
                        Spacer()
                        Button("기록 삭제") {
                            viewmodel.deleteHistory()
                        }
                        .tint(.blue)
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                    
                    ForEach(viewmodel.searchHistory, id: \.self) { history in
                        Button(history, action: {
                            viewmodel.setSearchQuery(history)
                            viewmodel.setSubmit(to: true)
                        })
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                } else {
                    ForEach(viewmodel.searchResults, id: \.self) { app in
                        SearchResultCell(app: app)
                            .listRowInsets(EdgeInsets(top: .spacing(multiplier: 2), leading: 0, bottom: .spacing(multiplier: 2), trailing: 0))
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .padding()
            .navigationTitle("검색")
            .listStyle(.plain)
            .searchable(text: $viewmodel.searchQuery, prompt: "App Store")
            .searchSuggestions{
                if !viewmodel.isSubmitted {
                    ForEach(viewmodel.searchResults, id: \.self) { app in
                        Label(app.title, systemImage: "magnifyingglass")
                            .foregroundColor(.secondary)
                            .searchCompletion(app.title)
                    }
                }
            }
            .onSubmit(of: .search) {
                viewmodel.setSubmit(to: true)
            }
        }
       
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
