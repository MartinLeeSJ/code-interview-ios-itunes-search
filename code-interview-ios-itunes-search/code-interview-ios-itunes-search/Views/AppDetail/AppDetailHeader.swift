//
//  AppDetailHeader.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppDetailHeader: View {
    private let title: String
    private let iconUrl: String
    private let sellerName: String
    private let genre: String
    private let url: String
    private let iconSize: CGFloat
    
    init(
        title: String,
        iconUrl: String,
        sellerName: String,
        genre: String,
        url: String,
        iconSize: CGFloat
    ) {
        self.title = title
        self.iconUrl = iconUrl
        self.sellerName = sellerName
        self.genre = genre
        self.url = url
        self.iconSize = iconSize
    }
    
    
    
    var body: some View {
        HStack(alignment: .center, spacing: .spacing(multiplier: 2)) {
            AppIconView(url: URL(string: iconUrl), iconWidth: iconSize)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3.bold())
                    Text(sellerName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    HStack {
                        DownloadButton(.borderedProminent) { }
                        Spacer()
                        ShareLink(item: URL(string: url)!) {
                            Image(systemName: "square.and.arrow.up")
                                .imageScale(.large)
                        }
                    }
                } 
            }
    }
}

struct AppDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        let sample = Application.sample
        AppDetailHeader(
            title: sample.title,
            iconUrl: sample.iconUrl,
            sellerName: sample.sellerName,
            genre: sample.primaryGenreName,
            url: sample.url,
            iconSize: 100
        )
            
    }
}
