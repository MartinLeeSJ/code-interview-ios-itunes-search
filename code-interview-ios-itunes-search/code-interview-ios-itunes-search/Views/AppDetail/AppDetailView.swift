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
            let appIconSize = geo.size.width * 2 / 7
            ScrollView {
                LazyVStack(spacing: .spacing(multiplier: 3)) {
                    AppDetailHeader(app: app, iconSize: appIconSize)
                        .frame(height: appIconSize)
                    

                    AppInfoBadgesScroll(app: app)
                    
                    AppReleaseNotes(releaseNotes: app.releaseNotes,
                                    version: app.version,
                                    currentVersionReleaseDate: app.currentVersionReleaseDate)
                    
                    AppScreenShots()
                    
                    AppDescription(app.description, sellerName: app.sellerName)
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    func AppScreenShots() -> some View {
        HStack {
            Text("미리보기")
                .font(.title3.bold())
            Spacer()
        }
        .padding(.bottom, .spacing(multiplier: -2))
        
        IPhoneScreenShotsScroll(screenShotUrls: app.screenshotUrls)
        
        Divider()
    }
}

struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView(app: Application.sample)
    }
}
