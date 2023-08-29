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
    private let app: Application
    
    init(app: Application) {
        self.app = app
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                Divider()
                HStack(spacing: .zero) {
                    userRating(rating: app.averageUserRating, count: app.userRatingCount)
                    
                    contentAdvisoryRating(rating: app.contentAdvisoryRating)
                    
                    sellerInfo(name: app.sellerName)
                    
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
        Badge(title: "\(count.formatPeopleNumber())개의 평가") {
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
    
    private func languageInfo() -> some View {
        Badge(title: "언어") {
            Text("KO")
        } bottom: {
            Text("한국어")
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

struct AppDetailHeaderScroll_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoBadges(app: Application.sample)
    }
}
