//
//  DownloadButton.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct DownloadButton<Style>: View where Style : PrimitiveButtonStyle {
  
    let buttonStyle: Style

    init(_ style: Style = .bordered) {
        self.buttonStyle = style
    }
    
    var body: some View {
        Button {
            
        } label: {
            Text("받기")
                .font(.subheadline.bold())
                .padding(.horizontal, 16)
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(buttonStyle)
        
    }
}

struct DownloadButton_Previews: PreviewProvider {
    static var previews: some View {
        DownloadButton()
    }
}
