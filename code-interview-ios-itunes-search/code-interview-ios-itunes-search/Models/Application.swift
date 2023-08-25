//
//  Application.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import Foundation

enum Device: String {
    case iphone
    case ipad
    case appletv = "tv"
}

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
    var genres: [String]
    var languages: [String]
    var fileSizeBytes: String
    
    var contentAdvisoryRating: String
    var averageUserRating: Double
    var userRatingCount: Int
    
    var version: String
    var releaseNotes: String
    var currentVersionReleaseDate: Date
    var minimumOsVersion: String
    var supportedDevices: [String]
    
    ///  스크린샷이 있는 디바이스 배열
    var screenshotDevices: [Device] {
        var devices = [Device]()
        if !screenshotUrls.isEmpty { devices.append(.iphone)}
        if !ipadScreenshotUrls.isEmpty { devices.append(.ipad)}
        if !appletvScreenshotUrls.isEmpty { devices.append(.appletv)}
        return devices
    }
    
}



 


