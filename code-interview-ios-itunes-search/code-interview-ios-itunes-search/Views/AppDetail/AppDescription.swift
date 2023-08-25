//
//  AppDescription.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/25.
//

import SwiftUI

struct AppDescription: View {
    let description: String
    let sellerName: String
    
    init(_ description: String, sellerName: String) {
        self.description = description
        self.sellerName = sellerName
    }
    
    private let fontSize: CGFloat = 14
    private let lineSpacing: CGFloat = 10
    private let lineLimit: Int = 3

    
    var body: some View {
        VStack(alignment: .leading, spacing: .spacing(multiplier: 2)) {
            ExpandableText(description,
                           fontSize: fontSize,
                           lineSpacing: lineSpacing,
                           lineLimit: lineLimit)
            
            aboutDeveloperLink
           
            Divider()
        }
    }
    
    var aboutDeveloperLink: some View {
        NavigationLink {
            
        } label: {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("Apple")
                        .foregroundColor(.blue)
                    Text("개발자")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
            .font(.system(size: fontSize))
        }
    }
   
}

struct AppDescription_Previews: PreviewProvider {
    static var previews: some View {
        AppDescription(Application.sample.description, sellerName: Application.sample.sellerName)
    }
}
