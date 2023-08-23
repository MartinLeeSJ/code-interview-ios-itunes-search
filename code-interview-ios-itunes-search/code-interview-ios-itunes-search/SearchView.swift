//
//  SearchView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchView: View {
    @State private var query: String = ""
    private let searchList: [String] = ["녹음기", "엠넷", "pitu", "의지의 히어로", "구글맵", "진에어", "grab"]
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("최근 검색어")
                    .font(.title.bold())
                List(searchList, id: \.self) { string in
                    Button(string, action: {})
                }
                .listStyle(.plain)
                .listItemTint(.blue)
            }
            .padding()
            .navigationTitle("검색")
            .searchable(text: $query)
            .searchSuggestions {
                ForEach(searchList, id: \.self) { string in
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text(string)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
