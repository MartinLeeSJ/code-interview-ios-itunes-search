//
//  SearchResultView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/29.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: .spacing(multiplier: 4)) {
                    ForEach(viewModel.searchResults, id: \.self) { app in
                        SearchResultCell(app: app)
                    }
                }
            }
            .scrollIndicators(.never)
        }
        .overlay(alignment: .center) {
            if viewModel.searchResults.isEmpty {
                emptyResult
            }
        }
        .opacity(viewModel.isLoaded ? 1 : 0)
    }
    
    private var emptyResult: some View {
        VStack {
            Spacer()
            Text("결과 없음")
                .font(.largeTitle.bold())
            Text("\'\(viewModel.searchQuery)\'")
                .font(.body)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: SearchViewModel())
    }
}
