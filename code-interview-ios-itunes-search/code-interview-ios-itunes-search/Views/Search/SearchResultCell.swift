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
                cellHeader()
                screenShots()
            }
        }
    }
}

// MARK: - 앱 아이콘 제목 버튼
extension SearchResultCell {
    private func cellHeader() -> some View {
        HStack(alignment: .center, spacing: .spacing(multiplier: 2)) {
            AppIconView(url: URL(string: app.iconUrl), iconWidth: appIconWidth)
            
            titleAndSellerName()
            
            Spacer()
            
            DownloadButton {}
        }
    }
    
    private func titleAndSellerName() -> some View {
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
    
    private var minHeight: CGFloat {
        return 196.0
    }
    
    private var maxHeight: CGFloat {
        return 348.0
    }
    
    @ViewBuilder
    private func screenShots() -> some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(screenShotUrlsPrefix, id: \.self) { urlString in
                CachedAsyncImage(url: URL(string: urlString)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(minHeight: minHeight, maxHeight: maxHeight)
                            .cornerRadius(girdCellCornerRadius)
                    case .empty:
                        screenShotPlaceHolder
                            .overlay { ProgressView() }
                    case .failure:
                        screenShotPlaceHolder
                            .overlay {
                                Image(systemName: "exclamationmark")
                                    .imageScale(.large)
                            }
                    @unknown default:
                        screenShotPlaceHolder
                            .overlay {
                                Image(systemName: "questionmark")
                                    .imageScale(.large)
                            }
                    }
                }
            }
        }
    }
    
    private var screenShotPlaceHolder: some View {
        RoundedRectangle(cornerRadius: girdCellCornerRadius)
            .foregroundStyle(.thinMaterial)
            .frame(minHeight: minHeight, maxHeight: maxHeight)
    }
}

struct SearchResultCell_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchResultCell(app: Application.sample)
    }
}
