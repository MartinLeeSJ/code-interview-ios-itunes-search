//
//  AppDetailHeader.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

//TODO: - API 연결
struct AppDetailHeader: View {
    let app: Application
    let iconSize: CGFloat
    private var title: String { app.title }
    private var iconUrl: String { app.iconUrl }
    private var sellerName: String { app.sellerName }
    private var genre: String { app.primaryGenreName }
    private var url: String { app.url }
    
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
        AppDetailHeader(app: Application.sample, iconSize: 100)
            
    }
}
