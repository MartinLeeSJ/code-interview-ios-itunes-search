//
//  AppReleaseNotes.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/25.
//

import SwiftUI

struct AppReleaseNotes: View {
    private let releaseNotes: String
    private let version: String
    private let currentVersionReleaseDate: Date
    
    private let fontSize: CGFloat = 14
    private let lineSpacing: CGFloat = 10
    private let lineLimit: Int = 3
    
    private var releaseDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "KO")
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .full
        return formatter.localizedString(for: currentVersionReleaseDate, relativeTo: Date.now)
    }
    
    init(
        releaseNotes: String,
        version: String,
        currentVersionReleaseDate: Date
    ) {
        self.releaseNotes = releaseNotes
        self.version = version
        self.currentVersionReleaseDate = currentVersionReleaseDate
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing(multiplier: 2)) {
            HStack(alignment: .firstTextBaseline) {
                Text("새로운 기능")
                    .font(.title3.bold())
                Spacer()
                
                NavigationLink {
                    
                } label: {
                    Text("버전 기록")
                }
            }
            .padding(.bottom, .spacing(multiplier: -1))
            
            HStack {
                Text("버전 \(version)")
                Spacer()
                Text(releaseDateString)
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            ExpandableText(
                releaseNotes,
                fontSize: fontSize,
                lineSpacing: lineSpacing,
                lineLimit: lineLimit
            )
                
            Divider()  
        }
    }
}

struct AppReleaseNotes_Previews: PreviewProvider {
    static var previews: some View {
        AppReleaseNotes(releaseNotes: Application.sample.releaseNotes,
                        version: Application.sample.version,
                        currentVersionReleaseDate: Application.sample.currentVersionReleaseDate)
    }
}
