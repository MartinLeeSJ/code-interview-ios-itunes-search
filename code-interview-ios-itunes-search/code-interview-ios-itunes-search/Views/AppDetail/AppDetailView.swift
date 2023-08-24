//
//  AppDetailView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppDetailView: View {
    let app: Application
    var body: some View {
        
        GeometryReader { geo in
            let appIconSize = geo.size.width / 3
            ScrollView {
                LazyVStack(spacing: 24) {
                    AppDetailHeader(app: app, iconSize: appIconSize)
                        .frame(height: appIconSize)
                    AppBriefInfoScroll(app: app)
                }
                .padding()
            }
        }
        
        
    }
}

struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView(app: Application.sample)
    }
}
