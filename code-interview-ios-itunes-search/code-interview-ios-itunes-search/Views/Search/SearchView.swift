//
//  SearchView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    @State private var query: String = ""
    @State private var isSubmitted: Bool = false
    private var searchList: [String] = ["녹음기", "엠넷", "pitu", "의지의 히어로", "구글맵", "진에어", "grab"]
    
    var body: some View {
        NavigationStack {
            List {
                if !isSearching {
                    Text("최근 검색어")
                        .font(.title2.bold())
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                }
                ForEach(searchList, id: \.self) {string in
                    Button(string, action: {
                        query = string
                        print("isSearching? : \(isSearching)")
                    })
                    .onSubmit(of: .search) {
                        isSubmitted = true
                    }
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
            }
            .padding()
            .navigationTitle("검색")
            .listStyle(.plain)
            .searchable(text: $query, prompt: "App Store")
            .onSubmit(of: .search) {
                isSubmitted = true
            }
        }
       
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
