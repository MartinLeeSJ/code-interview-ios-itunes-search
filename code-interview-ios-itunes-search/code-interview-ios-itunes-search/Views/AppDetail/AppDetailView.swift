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
                    
                    AppInfoBadges(
                        averageUserRating: app.averageUserRating,
                        userRatingCount: app.userRatingCount,
                        contentAdvisoryRating: app.contentAdvisoryRating,
                        sellerName: app.sellerName,
                        languages: app.languages
                    )
                    
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
                    
                    AppInfoList(
                        sellerName: app.sellerName,
                        fileSizeBytes: app.fileSizeBytes,
                        primaryGenreName: app.primaryGenreName,
                        languages: app.languages
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
