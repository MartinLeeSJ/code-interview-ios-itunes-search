//
//  FiveStarRating.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import SwiftUI

struct RatingStar: View {
    var rating: CGFloat
    var color: Color
    var index: Int
    
    
    var maskRatio: CGFloat {
        let mask = rating - CGFloat(index)
        
        switch mask {
        case 1...: return 1
        case ..<0: return 0
        default: return mask
        }
    }


    init(rating: Decimal, color: Color, index: Int) {
        self.rating = CGFloat(Double(rating.description) ?? 0)
        self.color = color
        self.index = index
    }


    var body: some View {
        GeometryReader { star in
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(self.color)
                .mask(
                    Rectangle()
                        .size(
                            width: star.size.width * self.maskRatio,
                            height: star.size.height
                        )
                    
                )
        }
    }
}




private struct BackgroundStars: View {
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<5) { _ in
                Image(systemName: "star")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
            }
        }
    }
}

private struct ForegroundStars: View {
    var rating: Decimal
    

    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<5) { index in
                RatingStar(
                    rating: self.rating,
                    color: .secondary,
                    index: index
                )
            }
        }
    }
}


struct FiveStarRating: View {
    var rating: Decimal
    
    var body: some View {
        BackgroundStars()
            .overlay {
                ForegroundStars(rating: rating)
            }
            
        
            
    }
}

struct FiveStarRating_Previews: PreviewProvider {
    static var previews: some View {
        FiveStarRating(rating: 3.88)
            .frame(maxWidth: 120)
            .border(.red)
    }
}
