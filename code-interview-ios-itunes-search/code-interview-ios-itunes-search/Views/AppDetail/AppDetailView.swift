//
//  AppDetailView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppDetailView: View {
    let app: Application
    
    @State private var isScreenShotExpanded: Bool = false
    
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
                    
                    appScreenShots()
                    
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


extension AppDetailView {
    @ViewBuilder
    func appScreenShots() -> some View {
        let firstDevice = app.screenshotDevices.first ?? .iPhone
        HStack {
            Text("미리보기")
                .font(.title3.bold())
            Spacer()
        }
        .padding(.bottom, .spacing(multiplier: -2))
        
        if isScreenShotExpanded {
            ForEach(app.screenshotDevices, id: \.self) { device in
                ScreenShotScroll(screenShotUrls: app.getScreenShotUrls(of: device))
                screenShotsFooter(of: device)
            }
        } else {
            ScreenShotScroll(screenShotUrls: app.getScreenShotUrls(of: firstDevice))
            screenShotsFooter(of: firstDevice)
        }
        Divider()
    }
    
    @ViewBuilder
    func screenShotsFooter(of device: Application.Device) -> some View {
        let description = app.screenShotDevicesDescription(
            devices: isScreenShotExpanded ? [device] : app.screenshotDevices
        )
        
        HStack {
            footerSystemImages(of: device)
            
            Text(description)
                .font(.system(size: 14))
            Spacer()
            
            if !isScreenShotExpanded && app.screenshotDevices.count != 1 {
                Button {
                    isScreenShotExpanded = true
                } label: {
                    Image(systemName: "chevron.down")
                }
            }
        }
        .padding(.horizontal)
        .foregroundColor(.secondary)
    }
    
    @ViewBuilder
    func footerSystemImages(of exactDevice: Application.Device) -> some View {
        if !isScreenShotExpanded {
            ForEach(app.screenshotDevices, id: \.self) { device in
                device.image
                    .imageScale(.medium)
            }
        } else {
            exactDevice.image
                .imageScale(.medium)
        }
    }
    
    
}

struct AppDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailView(app: Application.sample)
    }
}
