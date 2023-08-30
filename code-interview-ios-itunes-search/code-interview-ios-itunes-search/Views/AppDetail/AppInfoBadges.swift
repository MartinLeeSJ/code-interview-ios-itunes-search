//
//  AppInfoBadges.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

fileprivate struct Badge<Middle, Bottom>: View where Middle: View, Bottom: View {
    private let top: String
    private let middle: () -> Middle
    private let bottom: () -> Bottom
    
    private let minWidth: CGFloat = 100
    private let maxWidth: CGFloat = 105
    
    init(
        title top: String,
        middle: @escaping () -> Middle,
        bottom: @escaping () -> Bottom
    ) {
        self.top = top
        self.middle = middle
        self.bottom = bottom
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .spacing()) {
            Text(top)
                .font(.caption)
            middle()
                .font(.system(.title3,
                              design: .rounded,
                              weight: .bold))
            bottom()
                .font(.caption)
        }
        .frame(minWidth: minWidth, maxWidth: maxWidth)
        .foregroundColor(.secondary)
        
    }
}

struct AppInfoBadges: View {
    
    private let averageUserRating: Double
    private let userRatingCount: Int
    private let contentAdvisoryRating: String
    private let sellerName: String
    private let languages: [String]
    
    init(
        averageUserRating: Double,
        userRatingCount: Int,
        contentAdvisoryRating: String,
        sellerName: String,
        languages: [String]
    ) {
        self.averageUserRating = averageUserRating
        self.userRatingCount = userRatingCount
        self.contentAdvisoryRating = contentAdvisoryRating
        self.sellerName = sellerName
        self.languages = languages
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                Divider()
                HStack(spacing: .zero) {
                    userRating(rating: averageUserRating, count: userRatingCount)
                    
                    contentAdvisoryRating(rating: contentAdvisoryRating)
                    
                    sellerInfo(name: sellerName)
                    
                    languageInfo()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

// MARK: - All Badges
extension AppInfoBadges {
    private func userRatingScore(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        return formatter.string(from: number as NSNumber) ?? "0.0"
    }
    
    @ViewBuilder
    private func userRating(rating: Double, count: Int) -> some View {
        Badge(title: "\(count.peopleCountString())개의 평가") {
            Text(userRatingScore(rating))
        } bottom: {
            FiveStarRating(rating: Decimal(rating))
                .padding(.horizontal)
            
        }
        cellDivider
    }
    
    @ViewBuilder
    private func contentAdvisoryRating(rating: String) -> some View {
        Badge(title: "연령") {
            Text(rating)
        } bottom: {
            Text("세")
        }
        
        cellDivider
    }
    
    @ViewBuilder
    private func sellerInfo(name: String) -> some View {
        Badge(title: "개발자") {
            Image(systemName: "person.crop.square")
        } bottom: {
            Text(name)
        }
        
        cellDivider
    }
    
    private func mainLanguage(in languageCodes: [String]) -> String {
        if languageCodes.contains("KO") { return "KO" }
        return languageCodes.first ?? "KO"
    }
    
    private var mainLanguageName: String {
        mainLanguage(in:languages).languageNameFromISOCode() ?? "한국어"
    }
    
    private var languagesCountDescription: String {
        languages.count > 1 ? "+ \(languages.count - 1)개 언어" : (mainLanguageName)
    }
    
    private func languageInfo() -> some View {
        Badge(title: "언어") {
            Text(mainLanguage(in:languages))
        } bottom: {
            Text(languagesCountDescription)
        }
    }
}

// MARK: - Divider
extension AppInfoBadges {
    private var dividerHeight: CGFloat { 30 }
    
    private var cellDivider: some View {
        Divider()
            .frame(height: dividerHeight)
    }
}

