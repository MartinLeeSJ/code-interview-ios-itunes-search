//
//  Application+Decodable.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import Foundation

extension Application: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case sellerName
        case description
        
        case iconUrl = "artworkUrl512"
        case url = "trackViewUrl"
        case screenshotUrls
        case ipadScreenshotUrls
        case appletvScreenshotUrls
        
        case primaryGenreName
        case genres
        case languages = "languageCodesISO2A"
        case fileSizeBytes
        
        case contentAdvisoryRating
        case averageUserRating
        case userRatingCount
        
        case version
        case releaseNotes
        case currentVersionReleaseDate
        case minimumOsVersion
        case supportedDevices
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let rawId = try? values.decode(Int.self, forKey: .id)
        let rawTitle = try? values.decode(String.self, forKey: .title)
        let rawSellerName = try? values.decode(String.self, forKey: .sellerName)
        let rawDescription = try? values.decode(String.self, forKey: .description)
        
        let rawIconUrl = try? values.decode(String.self, forKey: .iconUrl)
        let rawUrl = try? values.decode(String.self, forKey: .url)
        let rawScreenshotUrls = try? values.decode([String].self, forKey: .screenshotUrls)
        let rawIpadScreenshotUrls = try? values.decode([String].self, forKey: .ipadScreenshotUrls)
        let rawAppletvScreenshotUrls = try? values.decode([String].self, forKey: .appletvScreenshotUrls)
        
        let rawPrimaryGenreName = try? values.decode(String.self, forKey: .primaryGenreName)
        let rawGenres = try? values.decode([String].self, forKey: .genres)
        let rawLanguages = try? values.decode([String].self, forKey: .languages)
        let rawFileSizeBytes = try? values.decode(String.self, forKey: .fileSizeBytes)
        
        let rawContentAdvisoryRating = try? values.decode(String.self, forKey: .contentAdvisoryRating)
        let rawAverageUserRating = try? values.decode(Double.self, forKey: .averageUserRating)
        let rawUserRatingCount = try? values.decode(Int.self, forKey: .userRatingCount)
        
        let rawVersion = try? values.decode(String.self, forKey: .version)
        let rawReleaseNotes = try? values.decode(String.self, forKey: .releaseNotes)
        let rawCurrentVersionReleaseDate = try? values.decode(String.self, forKey: .currentVersionReleaseDate)
        let rawMinimumOsVersion = try? values.decode(String.self, forKey: .minimumOsVersion)
        let rawSupportedDevices = try? values.decode([String].self, forKey: .supportedDevices)
        
        
        guard let id = rawId,
              let title = rawTitle,
              let sellerName = rawSellerName,
              let description = rawDescription,
              let iconUrl = rawIconUrl,
              let url = rawUrl,
              let screenshotUrls = rawScreenshotUrls,
              let ipadScreenshotUrls = rawIpadScreenshotUrls,
              let appletvScreenshotUrls = rawAppletvScreenshotUrls,
              let primaryGenreName = rawPrimaryGenreName,
              let genres = rawGenres,
              let languages = rawLanguages,
              let fileSizeBytes = rawFileSizeBytes,
              let contentAdvisoryRating = rawContentAdvisoryRating,
              let averageUserRating = rawAverageUserRating,
              let userRatingCount = rawUserRatingCount,
              let version = rawVersion,
              let releaseNotes = rawReleaseNotes,
              let currentVersionReleaseDate = rawCurrentVersionReleaseDate,
              let minimumOsVersion = rawMinimumOsVersion,
              let supportedDevices = rawSupportedDevices else {
            throw ApplicationError.missingData
        }
        
        
        
        self.id = id
        self.title = title
        self.description = description
        self.sellerName = sellerName
        self.iconUrl = iconUrl
        self.url = url
        self.screenshotUrls = screenshotUrls
        self.ipadScreenshotUrls = ipadScreenshotUrls
        self.appletvScreenshotUrls = appletvScreenshotUrls
        self.primaryGenreName = primaryGenreName
        self.genres = genres
        self.languages = languages
        self.fileSizeBytes = fileSizeBytes
        self.contentAdvisoryRating = contentAdvisoryRating
        self.averageUserRating = averageUserRating
        self.userRatingCount = userRatingCount
        self.version = version
        self.releaseNotes = releaseNotes
        self.currentVersionReleaseDate = currentVersionReleaseDate.covertToIso8601Date() ?? Date.now
        self.minimumOsVersion = minimumOsVersion
        self.supportedDevices = supportedDevices
    }
}
