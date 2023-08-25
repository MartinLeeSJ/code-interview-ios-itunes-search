//
//  AppReleaseNotes.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/25.
//

import SwiftUI

struct AppReleaseNotes: View {
    let releaseNotes: String
    let version: String
    let currentVersionReleaseDate: Date
    
    private var releaseDateString: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: currentVersionReleaseDate, relativeTo: Date.now)
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
            
            
            
            ExpandableText(releaseNotes)
                
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
