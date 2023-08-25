//
//  IPhoneScreenShotsScroll.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct IPhoneScreenShotsScroll: View {
    let screenShotUrls: [String]
    private let photoWidth: CGFloat = 200
    private var photoHeight: CGFloat { photoWidth * 2 }
    private var photoCornerRadius: CGFloat { photoWidth / 10 }
    private let photoSpacing: CGFloat = .spacing(multiplier: 2)
    
    
    var body: some View {
            HStack(alignment: .center, spacing: photoSpacing) {
                ForEach(0..<screenShotUrls.count, id: \.self) { index in
                    AsyncImage(url: URL(string: screenShotUrls[index])) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(photoCornerRadius)
                            .frame(minWidth: photoWidth, maxWidth: photoWidth, maxHeight: photoHeight)
                            
                            
                    } placeholder: {
                        RoundedRectangle(cornerRadius: photoCornerRadius)
                            .fill(.thinMaterial)
                            .frame(minWidth: photoWidth, maxWidth: photoWidth, minHeight: photoHeight)
                    }
                }
            }
            .scrollingHStack(.leading,
                             items: screenShotUrls.count,
                             itemWidth: photoWidth,
                         spacing: photoSpacing)
            
         
        
    }
}

struct AppScreenShotsScroll_Previews: PreviewProvider {
    static var previews: some View {
        IPhoneScreenShotsScroll(screenShotUrls: Application.sample.screenshotUrls)
    }
}
