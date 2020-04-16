//
//  SwiftAssignmentUITests.swift
//  SwiftAssignmentUITests
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest

let kTimeOut = 8.0

class SwiftAssignmentUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }
    
    func testTableInteraction() {
        app.launch()
     
        // Assert that we are displaying the tableview
        let articleTableView = app.tables["table--dataTableView"]
        _ = articleTableView.waitForExistence(timeout: kTimeOut)

        XCTAssertTrue(articleTableView.exists, "The article tableview exists")
     
        // Get an array of cells
        let tableCells = articleTableView.cells
        
        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
         
            let promise = expectation(description: "Wait for table cells")
         
            for index in stride(from: 0, to: count, by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: index)
                XCTAssertTrue(tableCell.exists, "The \(index) cell is in place on the table")
                // Does this actually take us to the next screen
                tableCell.tap()
         
                if index == (count - 1) {
                    promise.fulfill()
                }
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
         
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }

    override func tearDown() {
        super.tearDown()
    }
}
