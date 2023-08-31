//
//  ScreenShotScroll.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct ScreenShotScroll: View {
    private let screenShotUrls: [String]
    
    init(screenShotUrls: [String]) {
        self.screenShotUrls = screenShotUrls
    }

    private let imageWidth: CGFloat = 250
    private let portraitImageSize = CGSize(width: 1, height: 2)
    private let imageSpacing: CGFloat = .spacing(multiplier: 2)
    private var imageCornerRadius: CGFloat { imageWidth / 10 }
    
    private var imageSize: CGSize {
        guard let firstUrl = screenShotUrls.first else {
            return portraitImageSize
        }
        guard let size = URL(string: firstUrl)?.itunesScreenShotSize() else {
            return portraitImageSize
        }
        
        return size
    }
    
    
    var body: some View {
            HStack(alignment: .center, spacing: imageSpacing) {
                ForEach(0..<screenShotUrls.count, id: \.self) { index in
                    CachedAsyncImage(url: URL(string: screenShotUrls[index])) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(imageSize, contentMode: .fit)
                                .cornerRadius(imageCornerRadius)
                                .frame(width: imageWidth)
                        default:
                            RoundedRectangle(cornerRadius: imageCornerRadius)
                                .fill(.thinMaterial)
                                .aspectRatio(imageSize, contentMode: .fit)
                                .frame(width: imageWidth)
                        }
                    }
                    .imageBorderLine(cornerRadius: imageCornerRadius)
                }
            }
            .snapScrollingHStack(
                .leading,
                items: screenShotUrls.count,
                itemWidth: imageWidth,
                spacing: imageSpacing
            )
        
         
        
    }
}

struct AppScreenShotsScroll_Previews: PreviewProvider {
    static var previews: some View {
        ScreenShotScroll(screenShotUrls: Application.sample.screenshotUrls)
    }
}
