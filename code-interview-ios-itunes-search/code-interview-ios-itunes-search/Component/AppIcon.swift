//
//  AppIcon.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppIcon: View {
    let url: String
    let iconWidth: CGFloat
    var iconRadius: CGFloat {
        iconWidth / 5
    }
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: iconWidth)
                .clipShape(RoundedRectangle(cornerRadius: iconRadius))
        } placeholder: {
            ProgressView()
                .scaledToFit()
                .frame(width: iconWidth, height: iconWidth)
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: iconRadius))
        }

    }
}

struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
        AppIcon(url: Application.sample.iconUrl, iconWidth: 100)
    }
}
