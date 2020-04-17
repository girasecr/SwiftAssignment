//
//  DataViewModelTests.swift
//  SwiftAssignmentTests
//
//  Created by Chetan Girase on 16/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest
@testable import SwiftAssignment

class DataViewModelTests: SwiftAssignmentBaseTest {
    // MARK: - Test Cases Life Cycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Model functions - Test Get api data frunction with json file
    func testGetApiData() {
        let expect = XCTestExpectation.init(description: "testDataApiResponse")
        getModelData(forResource: "TestData", ofType: "json") {(data, _) in
            if let response = data {
                let json = String(data: response, encoding: String.Encoding.utf8)
                XCTAssert(json != nil)
                let jsonData = response
                let dataModel = try? JSONDecoder().decode(DataModel.self, from: jsonData)
                XCTAssertNotNil(dataModel)
                expect.fulfill()
            }
        }
        wait(for: [expect], timeout: 5)
    }
}
