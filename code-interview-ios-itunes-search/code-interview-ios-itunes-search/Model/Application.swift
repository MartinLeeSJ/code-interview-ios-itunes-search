//
//  Application.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import Foundation

struct Application: Identifiable {
    var id: Int // trackId
    var title: String
    var description: String
    var sellerName: String

    var iconUrl: String
    var url: String
    var screenshotUrls: [String]
    var ipadScreenshotUrls: [String]
    var appleTvScreenshotUrls: [String]
    
    var primaryGenreId: Int // primaryGenreId
    var genreIds: [String]
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
}



 


