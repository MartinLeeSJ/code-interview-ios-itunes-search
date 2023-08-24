//
//  AppScreenShotsScroll.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct AppScreenShotsScroll: View {
    var colors: [Color] = [.blue, .green, .red, .orange]
    
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            ForEach(0..<colors.count, id: \.self) { i in
                colors[i]
                    .frame(width: 250, height: 400, alignment: .center)
                    .cornerRadius(10)
            }
        }
        .scrollingHStack(.center, items: colors.count, itemWidth: 250, spacing: 30)
        
    }
}

struct AppScreenShotsScroll_Previews: PreviewProvider {
    static var previews: some View {
        AppScreenShotsScroll()
    }
}
