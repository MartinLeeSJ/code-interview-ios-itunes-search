//
//  SearchResultCell.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchResultCell: View {
    let app: Application
    
    private var screenShotUrlsPrefix: [String] {
        Array(app.screenshotUrls.prefix(upTo: 3))
    }
    
    private let gridSpacing: CGFloat = 8
    private let appIconWidth: CGFloat = 60
    private let appIconRadius: CGFloat = 8
    private let girdCellCornerRadius: CGFloat = 10
    
    var body: some View {
        NavigationLink {
            AppDetailView(app: app)
        } label: {
        VStack(spacing: .spacing(multiplier: 2)) {
            HStack(alignment: .center, spacing: .spacing(multiplier: 2)) {
                AsyncImage(url: URL(string: app.iconUrl)!) { image in
                    image
                        .resizable()
                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                        .cornerRadius(appIconRadius)
                        .frame(width: appIconWidth)
                    
                } placeholder: {
                    RoundedRectangle(cornerRadius: appIconRadius)
                        .foregroundStyle(.thinMaterial)
                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fit)
                        .frame(width: appIconWidth)
                        .overlay {
                            ProgressView()
                        }
                }
                
                
                VStack(alignment: .leading) {
                    Text(app.title)
                        .font(.title3)
                    Text(app.sellerName)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                DownloadButton {
                    //ToDo
                }
            }
            
            LazyVGrid(columns: .init(repeating: .init(.flexible(), spacing: gridSpacing), count: 3)) {
                ForEach(screenShotUrlsPrefix, id: \.self) { urlString in
                    AsyncImage(url: URL(string: urlString)!) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(girdCellCornerRadius)
                        
                        
                    } placeholder: {
                        RoundedRectangle(cornerRadius: girdCellCornerRadius)
                            .foregroundStyle(.thinMaterial)
                            .aspectRatio(CGSize(width: 1, height: 2), contentMode: .fit)
                    }
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
