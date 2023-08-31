//
//  Application.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import Foundation
import SwiftUI



struct Application: Identifiable, Hashable {
    var id: Int // trackId
    var title: String
    var description: String
    var sellerName: String

    var iconUrl: String
    var url: String
    var screenshotUrls: [String]
    var ipadScreenshotUrls: [String]
    var appletvScreenshotUrls: [String]
    
    var primaryGenreName: String 
    var languages: [String]
    var fileSizeBytes: String
    
    var contentAdvisoryRating: String
    var averageUserRating: Double
    var userRatingCount: Int
    
    var version: String
    var releaseNotes: String
    var currentVersionReleaseDate: Date
    var minimumOsVersion: String
}


// MARK: - 스크린샷 제공 디바이스
extension Application {
    enum Device: String {
        case iPhone
        case iPad
        case appletv = "Apple TV"
        
        var image: Image {
            switch self {
            case .iPhone: return Image(systemName: "iphone")
            case .iPad: return Image(systemName: "ipad")
            case .appletv: return Image(systemName: "tv")
            }
        }
    }
    
    ///  스크린샷이 있는 디바이스 배열
    var screenshotDevices: [Device] {
        var devices = [Device]()
        if !screenshotUrls.isEmpty { devices.append(.iPhone)}
        if !ipadScreenshotUrls.isEmpty { devices.append(.iPad)}
        if !appletvScreenshotUrls.isEmpty { devices.append(.appletv)}
        return devices
    }
    
    func getScreenShotUrls(of device: Device) -> [String] {
        switch device {
        case .iPhone: return self.screenshotUrls
        case .iPad: return self.ipadScreenshotUrls
        case .appletv: return self.appletvScreenshotUrls
        }
    }
    
    func screenShotDevicesDescription(devices: [Device]) -> String {
        var result: String = ""
        
        for (index, device) in devices.enumerated() {
            switch index {
            case 0: result += device.rawValue
            case 1 where devices.count != 2: result += ", \(device.rawValue)"
            case 1, 2: result += "및 \(device.rawValue)용 앱"
            default: continue
            }
        }
        return result
    }
}

 


