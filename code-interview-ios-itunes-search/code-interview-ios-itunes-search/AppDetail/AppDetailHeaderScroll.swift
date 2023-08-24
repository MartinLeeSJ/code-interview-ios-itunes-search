//
//  AppDetailHeaderScroll.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppDetailHeaderScrollCell<Label>: View where Label : View {
    let top: String
    let middle: () -> Label
    let bottom: () -> Label
    
    init(title top: String, middle: @escaping () -> Label, bottom: @escaping () -> Label) {
        self.top = top
        self.middle = middle
        self.bottom = bottom
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text(top)
                .font(.caption)
            middle()
                .font(.system(.title3,
                              design: .rounded,
                              weight: .bold))
            bottom()
                .font(.caption)
        }
        .foregroundColor(.secondary)
    }
}

struct AppDetailHeaderScroll: View {
    var body: some View {
        ScrollView(.horizontal) {
            
        }
    }
}

struct AppDetailHeaderScroll_Previews: PreviewProvider {
    static var previews: some View {
        AppDetailHeaderScroll()
    }
}
