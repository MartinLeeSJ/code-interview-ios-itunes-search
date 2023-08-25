//
//  AppDetailHeaderScroll.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppInfoBadge<M, B>: View where M : View, B : View {
    let top: String
    let middle: () -> M
    let bottom: () -> B
    
    private let minWidth: CGFloat = 100
    private let maxWidth: CGFloat = 105
    
    init(title top: String, middle: @escaping () -> M, bottom: @escaping () -> B) {
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

struct AppInfoBadgesScroll: View {
    let app: Application
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

extension AppInfoBadgesScroll {
    private func userRatingString(_ rating: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        return formatter.string(from: rating as NSNumber) ?? "0.0"
    }
   
    @ViewBuilder
    func userRating(rating: Double, count: Int) -> some View {
        AppInfoBadge(title: "\(count)개 의 평가") {
            Text(userRatingString(rating))
        } bottom: {
            FiveStarRating(rating: Decimal(rating))
                .padding(.horizontal)
                
        }
        cellDivider
    }
    
    @ViewBuilder
    func contentAdvisoryRating(rating: String) -> some View {
        AppInfoBadge(title: "연령") {
            Text(rating)
        } bottom: {
            Text("세")
        }
        
        cellDivider
    }
    
    @ViewBuilder
    func sellerInfo(name: String) -> some View {
        AppInfoBadge(title: "개발자") {
            Image(systemName: "person.crop.square")
        } bottom: {
            Text(name)
        }
        
        cellDivider
    }
    
    @ViewBuilder
    func languageInfo() -> some View {
        AppInfoBadge(title: "언어") {
            Text("KO")
        } bottom: {
            Text("한국어")
        }
    }
}


extension AppInfoBadgesScroll {
    private var dividerHeight: CGFloat { 30 }
    
    var cellDivider: some View {
        Divider()
            .frame(height: dividerHeight)
    }
}

struct AppDetailHeaderScroll_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoBadgesScroll(app: Application.sample)
    }
}
