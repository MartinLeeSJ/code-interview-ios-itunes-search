//
//  AppDetailHeader.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

//TODO: - API 연결
struct AppDetailHeader: View {
    let title: String
    let sellerName: String
    let genre: String
    let urlString: String
    
    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .top, spacing: 16) {
                //API에서 받아온 이미지가 나올 예정
                Image(systemName: "swift")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * (1 / 3) )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.black.opacity(0.5), lineWidth: 1)
                            .aspectRatio(1, contentMode: .fill)
                    }
                
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
                        ShareLink(item: URL(string: urlString)!) {
                            Image(systemName: "square.and.arrow.up")
                                .imageScale(.large)
                        }
                    
                            
                    }
                }
            }
        }
    }
}

struct AppDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailHeader(title: "케어크루", sellerName: "HurayPositive Corp.", genre: "건강", urlString: "https://developer.apple.com/xcode/swiftui")
            .frame(height: 140)
            .padding()
            
    }
}
