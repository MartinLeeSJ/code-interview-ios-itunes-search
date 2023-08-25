//
//  CGFloat+Spacing.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/25.
//

import Foundation

extension CGFloat {
    static func spacing(multiplier: Int = 1) -> Self {
        let basicSpacing: CGFloat = 8.0
        return basicSpacing * CGFloat(multiplier)
    }
}
