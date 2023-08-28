//
//  URL+ImageSize.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/29.
//

import Foundation

extension URL {
    /// 스크린샷 Url의 PathComponent 에서 마지막 요소가 "392x696bb.jpg" 이렇게 사이즈를 나타낼 경우
    /// 그 사이즈를 구해주는 함수
    ///
    /// sample screenshot URL:
    /// "https://is1-ssl.mzstatic.com/image/thumb/PurpleSource116/v4/fa/99/e9/fa99e92e-be30-e3e8-83f3-091357bc590d/c34a1cb1-7dcd-498e-b667-c71f552f70ee_Screenshots_066-Summer-LivingRoom-1242x2208_en.jpg/392x696bb.jpg"
    /// - Returns: 스크린샷 이미지의 너비 높이 값, 구할 수 없을 경우 nil
    func itunesScreenShotSize() -> CGSize? {
      
    
        guard let lastPathComponent = self.pathComponents.last else { return nil }
        guard let imageSize = lastPathComponent.split(separator: "bb").first else { return nil }
       
        let array = String(imageSize).split(separator: "x")
        
        guard let first = array.first,
              let second = array.last,
              let width = Double(first),
              let height = Double(second) else {
            return nil
        }
        
        return CGSize(width: width, height: height)
    }
}
