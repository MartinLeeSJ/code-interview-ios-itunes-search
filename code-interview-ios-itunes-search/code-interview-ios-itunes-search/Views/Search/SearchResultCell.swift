//
//  SearchResultCell.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchResultCell: View {
    @Environment(\.colorScheme) var colorScheme
    let app: Application
    
    private let gridSpacing: CGFloat = 8
    private let appIconWidth: CGFloat = 60
    private let appIconRadius: CGFloat = 8
    private let girdCellCornerRadius: CGFloat = 10
    
    var body: some View {
        NavigationLink {
            AppDetailView(app: app)
        } label: {
            VStack(spacing: .spacing(multiplier: 2)) {
                cellHeader
                screenShots
            }
        }
    }
}

// MARK: - 앱 아이콘 제목 버튼
extension SearchResultCell {
    @ViewBuilder
    private var cellHeader: some View {
        HStack(alignment: .center, spacing: .spacing(multiplier: 2)) {
            AppIconView(url: URL(string: app.iconUrl), iconWidth: appIconWidth)
            
            titleAndSellerName
            
            Spacer()
            
            DownloadButton {}
        }
    }
    
    private var titleAndSellerName: some View {
        VStack(alignment: .leading) {
            Text(app.title)
                .font(.body)
                .foregroundColor(colorScheme == .light ? .black : .white)
            Text(app.sellerName)
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .lineLimit(1)
    }
}

// MARK: - 앱 스크린샷
extension SearchResultCell {
    private var screenShotUrlsPrefix: [String] {
        Array(app.screenshotUrls.prefix(upTo: 3))
    }
    
    private var gridColumns: Array<GridItem> {
        Array(repeating: .init(.flexible(), spacing: gridSpacing), count: screenShotUrlsPrefix.count)
    }
    
    @ViewBuilder
    var screenShots: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(screenShotUrlsPrefix, id: \.self) { urlString in
                CachedAsyncImage(url: URL(string: urlString)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(minHeight: 196, maxHeight: 348)
                            .cornerRadius(girdCellCornerRadius)
                    case .empty:
                        RoundedRectangle(cornerRadius: girdCellCornerRadius)
                            .foregroundStyle(.thinMaterial)
                            .frame(minHeight: 196, maxHeight: 348)
                    case .failure:
                        RoundedRectangle(cornerRadius: girdCellCornerRadius)
                            .foregroundStyle(.thinMaterial)
                            .frame(minHeight: 196, maxHeight: 348)
                    @unknown default:
                        RoundedRectangle(cornerRadius: girdCellCornerRadius)
                            .foregroundStyle(.thinMaterial)
                            .frame(minHeight: 196, maxHeight: 348)
                    }
                }
            }
        }

    }
}

struct SearchResultCell_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchResultCell(app: Application.sample)
    }
}
