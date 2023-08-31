//
//  ImageBorderLine.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/31.
//

import SwiftUI

struct ImageBorderLine: ViewModifier {
    private let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.secondary, lineWidth: 0.2)
            }
    }
}

extension View {
    func imageBorderLine(cornerRadius: CGFloat) -> some View {
        modifier(ImageBorderLine(cornerRadius: cornerRadius))
    }
}
