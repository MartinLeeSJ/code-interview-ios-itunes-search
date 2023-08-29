//
//  AppDetailView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppDetailView: View {
    private let app: Application
    
    init(app: Application) {
        self.app = app
    }
    
    var body: some View {
        GeometryReader { geo in
            let appIconSize = geo.size.width * 2 / 7
            ScrollView {
                LazyVStack(spacing: .spacing(multiplier: 3)) {
                    AppDetailHeader(
                        title: app.title,
                        iconUrl: app.iconUrl,
                        sellerName: app.sellerName,
                        genre: app.primaryGenreName,
                        url: app.url,
                        iconSize: appIconSize
                    )
                    .frame(height: appIconSize)
                    
                    AppInfoBadges(app: app)
                    
                    AppReleaseNotes(
                        releaseNotes: app.releaseNotes,
                        version: app.version,
                        currentVersionReleaseDate: app.currentVersionReleaseDate
                    )
                    
                    AppScreenShots(app: app)
                    
                    
                    AppDescription(
                        app.description,
                        sellerName: app.sellerName
                    )
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView(app: Application.sample)
    }
}
