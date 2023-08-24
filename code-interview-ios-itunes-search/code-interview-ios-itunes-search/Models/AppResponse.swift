//
//  AppResponse.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//

import Foundation

struct AppResponse: Decodable {
    private (set) var applications: [Application] = []
    private enum CodingKeys: String, CodingKey {
        case results
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.applications = try container.decode([Application].self, forKey: .results)
    }
}


