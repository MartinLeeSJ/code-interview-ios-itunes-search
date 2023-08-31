//
//  AppIconView.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

fileprivate struct AppIconPlaceHolder<Content>: View where Content: View {
    private let radius: CGFloat
    private let width: CGFloat
    private let content: () -> Content
    
    init(
        radius: CGFloat,
        width: CGFloat,
        content: @escaping () -> Content
    ) {
        self.radius = radius
        self.width = width
        self.content = content
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: radius)
            .foregroundStyle(.thinMaterial)
            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
            .frame(width: width)
            .overlay(content: content)
    }
}

struct AppIconView: View {
    private let url: URL?
    private let iconWidth: CGFloat
    private var iconRadius: CGFloat {
        iconWidth / 5
    }
    
    init(url: URL?, iconWidth: CGFloat) {
        self.url = url
        self.iconWidth = iconWidth
    }
    
    var body: some View {
        CachedAsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .cornerRadius(iconRadius)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                    .frame(width: iconWidth)
            case .empty:
                AppIconPlaceHolder(radius: iconRadius, width: iconWidth) {
                    ProgressView()
                }
            case .failure:
                AppIconPlaceHolder(radius: iconRadius, width: iconWidth) {
                    Image(systemName: "exclamationmark")
                }
            @unknown default:
                AppIconPlaceHolder(radius: iconRadius, width: iconWidth) {
                    Image(systemName: "questionmark")
                }
            }
        }
        .imageBorderLine(cornerRadius: iconRadius)
    }
}

struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
        AppIconView(url: URL(string: Application.sample.iconUrl), iconWidth: 100)
    }
}
