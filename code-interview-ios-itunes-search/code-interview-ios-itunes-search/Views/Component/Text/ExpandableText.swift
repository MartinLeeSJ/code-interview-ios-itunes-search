//
//  ExpandableText.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/25.
//

import SwiftUI

struct ExpandableText: View {
    @State private var expanded: Bool = false
    @State private var truncated: Bool = false
   
    private let text: String
    private let fontSize: CGFloat
    private let lineSpacing: CGFloat
    private let lineLimit: Int
    
    init(_ text: String, fontSize: CGFloat = 16, lineSpacing: CGFloat = 0, lineLimit: Int = 3) {
        self.text = text
        self.fontSize = fontSize
        self.lineSpacing = lineSpacing
        self.lineLimit = lineLimit
    }
   
    private func determineTruncation(_ geometry: GeometryProxy) {
        let total = self.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: fontSize)],
            context: nil
        )
        
        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: fontSize))
                .lineSpacing(lineSpacing)
                .lineLimit(expanded ? nil : lineLimit)
                .background{
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            determineTruncation(geometry)
                        }
                    }
                }
            Spacer()
        }
        .overlay(alignment: .bottomTrailing) {
            if truncated && !expanded {
                toggleButton
            }
        }
    }
    var toggleButton: some View {
        Button {
            expanded.toggle()
        } label: {
            Text("더 보기")
                .font(.system(size: fontSize))
        }
        .padding(.horizontal)
        .background {
            Color.white
                .blur(radius: 2, opaque: false)
        }
        
    }
}
