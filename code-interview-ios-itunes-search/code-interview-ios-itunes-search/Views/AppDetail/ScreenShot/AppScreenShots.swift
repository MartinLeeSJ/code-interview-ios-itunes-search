//
//  AppScreenShots.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/29.
//

import SwiftUI

struct AppScreenShots: View {
    private let app: Application
    
    @State private var isScreenShotExpanded: Bool = false
    
    init(app: Application) {
        self.app = app
    }
    
    private var firstDevice: Application.Device { app.screenshotDevices.first ?? .iPhone }
    
    var body: some View {
        VStack {
            HStack {
                Text("미리보기")
                    .font(.title3.bold())
                Spacer()
            }
            
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
    }
}


extension AppScreenShots {
  
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

struct AppScreenShots_Previews: PreviewProvider {
    static var previews: some View {
        AppScreenShots(app: Application.sample)
    }
}
