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
    private let gridCellCornerRadius: CGFloat = 10
    
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
            
            DownloadButton()
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
    
    /// 스크린샷 URL string 배열중 검색 결과로 보여줄 부분을 앞에서부터 추리는 메서드
    /// - Parameter screenshotUrls: 스크린샷 URL string 배열
    /// - Returns: 맨 처음 사진이 Portrait이면 최대 3개의 url을 Landscape이면 1개의 url을 리턴한다.
    private func prefixOfScreenShotUrls(_ screenshotUrls: [String]) -> [String] {
        guard let firstUrl = screenshotUrls.first else { return [] }
        
        //첫번째 사진이 Portrait이 아니라 Landscape일 경우 첫번째 사진 URL String만 배열에 담아 내보낸다.
        guard let isPortraitImage = URL(string: firstUrl)?.isPortraitImage(),
              isPortraitImage == true
        else {
            return [firstUrl]
        }
        
        //스크린샷이 3장이 넘지 않을 경우 그대로 내보낸다
        guard screenshotUrls.count > 3 else {
            return screenshotUrls
        }
        
        //스크린샷이 3장이 넘을 경우 앞에서 3가지의 url만 내보낸다.
        return Array(screenshotUrls.prefix(upTo: 3))
    }
    
    
    private func basicImageSize(of url: URL?) -> CGSize {
        guard let isPortraitImage = url?.isPortraitImage() else { return CGSize(width: 1, height: 2) }
        return isPortraitImage ? CGSize(width: 1, height: 2) : CGSize(width: 2, height: 1)
    }
    
    private var gridColumns: Array<GridItem> {
        // screenShotUrlsPrefix의 길이가 1인 경우에만 count가 1
        let screenShotCount: Int = prefixOfScreenShotUrls(app.screenshotUrls).count
        return Array(
            repeating: .init(.flexible(), spacing: gridSpacing),
            count: screenShotCount == 1 ? 1 : 3
        )
    }
    
    @ViewBuilder
    private func screenShots() -> some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(prefixOfScreenShotUrls(app.screenshotUrls), id: \.self) { urlString in
                let url: URL? = URL(string: urlString)
                let imageSize: CGSize = url?.itunesScreenShotSize() ?? basicImageSize(of: url)
                
                CachedAsyncImage(url: URL(string: urlString)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(imageSize, contentMode: .fit)
                            .cornerRadius(gridCellCornerRadius)
                            
                    case .empty:
                        screenShotPlaceHolder(size: imageSize)
                            .overlay { ProgressView() }
                        
                    case .failure:
                        screenShotPlaceHolder(size: imageSize)
                            .overlay {
                                Image(systemName: "exclamationmark")
                                    .imageScale(.large)
                            }
                    @unknown default:
                        screenShotPlaceHolder(size: imageSize)
                            .overlay {
                                Image(systemName: "questionmark")
                                    .imageScale(.large)
                            }
                    }
                }
                .imageBorderLine(cornerRadius: gridCellCornerRadius)
            }
        }
    }
    
    private func screenShotPlaceHolder(size: CGSize) -> some View {
        RoundedRectangle(cornerRadius: gridCellCornerRadius)
            .foregroundStyle(.thinMaterial)
            .aspectRatio(size, contentMode: .fit)
    }
}

struct SearchResultCell_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchResultCell(app: Application.sample)
    }
}
