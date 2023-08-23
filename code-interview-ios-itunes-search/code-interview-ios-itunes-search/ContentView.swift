//
//  ContentView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct ContentView: View {
    enum Tab: String, Identifiable, CaseIterable {
        case today = "투데이"
        case game = "게임"
        case app = "앱"
        case update = "업데이트"
        case search = "검색"
        
        var id: Self { self }
        
        var imageName: String {
            switch self {
            case .today: return "doc.text.image"
            case .game: return "gamecontroller.fill"
            case .app: return "square.stack.3d.up.fill"
            case .update: return "square.and.arrow.down.fill"
            case .search: return "magnifyingglass"
            }
        }
    }
    
    var body: some View {
        TabView {
            ForEach(Tab.allCases) { tab in
                Group {
                    if tab == .search {
                        SearchView()
                    } else {
                        Text(tab.rawValue)
                    }
                }
                .tabItem {
                    Label(tab.rawValue, systemImage: tab.imageName)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
