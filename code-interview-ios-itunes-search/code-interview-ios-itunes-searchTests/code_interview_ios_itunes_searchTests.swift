//
//  code_interview_ios_itunes_searchTests.swift
//  code-interview-ios-itunes-searchTests
//
//  Created by Martin on 2023/08/24.
//

import XCTest
@testable import code_interview_ios_itunes_search

final class code_interview_ios_itunes_searchTests: XCTestCase {

    func testDecodeSearchResult() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let searchResults = try decoder.decode(AppResponse.self, from: testSearchResultData)
        
        XCTAssertEqual(searchResults.applications.count, 1)
    }
}
