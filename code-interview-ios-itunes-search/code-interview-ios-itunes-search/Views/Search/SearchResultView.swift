//
//  SearchResultView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/29.
//

import SwiftUI

struct SearchResultView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State private var emptyResultOpacity: Double = 0
    
    var body: some View {
        if viewModel.searchResults.isEmpty {
            emptyResult
        } else {
            ScrollView {
                LazyVStack(spacing: .spacing(multiplier: 4)) {
                    ForEach(viewModel.searchResults, id: \.self) { app in
                        SearchResultCell(app: app)
                    }
                }
            }
            .scrollIndicators(.never)
        }
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
        .opacity(emptyResultOpacity)
        .task {
            emptyResultOpacity = 0
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                emptyResultOpacity = 1
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(viewModel: SearchViewModel())
    }
}
