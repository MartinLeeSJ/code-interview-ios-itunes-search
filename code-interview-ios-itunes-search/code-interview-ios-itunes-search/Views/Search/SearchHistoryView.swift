//
//  SearchHistoryView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/30.
//

import SwiftUI

struct SearchHistoryView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.isSearching) var isSearching
    
    private let historyListRowInsets: EdgeInsets = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    var body: some View {
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
        .opacity(isSearching ? 0 : 1)
    }
}

