//
//  DownloadButton.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct DownloadButton<Style>: View where Style : PrimitiveButtonStyle {
    let buttonStyle: Style
    let text: String
    let action: () -> Void
    
    
    init(_ style: Style = .bordered, text: String = "받기", action: @escaping () -> Void = {}) {
        self.buttonStyle = style
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.subheadline.bold())
                .padding(.horizontal, 16)
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(buttonStyle)
        
    }
}

struct DownloadButton_Previews: PreviewProvider {
    static var previews: some View {
        DownloadButton(action: {})
    }
}
