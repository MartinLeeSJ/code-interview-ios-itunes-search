//
//  SearchResultCell.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/23.
//

import SwiftUI

struct SearchResultCell: View {
    var body: some View {
        NavigationLink {
            Text("test")
        } label: {
        GeometryReader { geo in
            let width = geo.size.width
            let appIconSize = width / 6
            let gridSpacing: CGFloat = 8
            let gridCellWidth = (width - gridSpacing * 2) / 3
            let gridCellHeight = gridCellWidth * 2.2
            
            VStack(spacing: 16) {
                HStack(alignment: .center, spacing: 16) {
                    RoundedRectangle(cornerRadius: appIconSize / 4)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: appIconSize)
                    VStack(alignment: .leading) {
                        Text("제목")
                            .font(.title3)
                        Text("부제목")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    
                    DownloadButton {
                      //ToDo
                    }
                }
                
                LazyVGrid(columns: .init(repeating: .init(.flexible(minimum: gridCellWidth), spacing: gridSpacing), count: 3)) {
                    ForEach(0..<3, id: \.self) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: gridCellHeight)
                    }
                }
            }
        }
    }
    }
}

struct SearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SearchResultCell()
                .padding()
        }
    }
}
