//
//  SearchHistoryList.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/30.
//

import SwiftUI

struct SearchHistoryList: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.isSearching) var isSearching
    
    private var exposedHistory: [String] {
        var length: Int
        length = min(10, viewModel.searchHistory.count - 1)
        length = max(length, 0)
        return Array(viewModel.searchHistory.prefix(upTo: length))
    }
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
            
            ForEach(exposedHistory, id: \.self) { history in
                Button {
                    viewModel.setSearchQuery(history)
                    viewModel.setIsSubmitted(to: true)
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

