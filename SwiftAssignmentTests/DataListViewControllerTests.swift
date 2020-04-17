//
//  DataListViewControllerTests.swift
//  SwiftAssignmentTests
//
//  Created by Chetan Girase on 16/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest
@testable import SwiftAssignment

class DataListViewControllerTests: XCTestCase {
    // MARK: - Properties/Constants
    var dataController: DataListViewController!
    struct CONSTANTS {
        static let cellIdentifier = "DataTableviewCell"
        static let apiExpectation = "Download Data from server"
    }

    // MARK: - UITest Cases Life Cycle
    override func setUp() {
        super.setUp()
        self.dataController = DataListViewController()
        self.dataController.loadView()
        self.dataController.viewDidLoad()
        let expectation = XCTestExpectation(description: CONSTANTS.apiExpectation)
        self.dataController.viewModel?.getApiData(complete: { (model) in
            XCTAssertNotNil(model, "No data was downloaded.")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: kTimeOut)
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Data Tableview Test Cases
    func testHasATableView() {
        XCTAssertNotNil(dataController.tableView)
    }

    func testTableViewHasDelegate() {
        XCTAssertNotNil(dataController.tableView.delegate)
    }

    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(dataController.conforms(to: UITableViewDelegate.self))
    }

    func testTableViewHasDataSource() {
        XCTAssertNotNil(dataController.tableView.dataSource)
    }

    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(dataController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(dataController.responds(to: #selector(dataController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(dataController.responds(to: #selector(dataController.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        let index = IndexPath(row: 0, section: 0)
        let cell = dataController.tableView(dataController.tableView, cellForRowAt: index) as? DataTableviewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = CONSTANTS.cellIdentifier
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableCellHasCorrectLabelText() {
        let index0 = IndexPath(row: 0, section: 0)
        let cell0 = dataController.tableView(dataController.tableView, cellForRowAt: index0) as? DataTableviewCell
        XCTAssertNotNil(cell0?.titleLabel.text)

        let index1 = IndexPath(row: 1, section: 0)
        let cell1 = dataController.tableView(dataController.tableView, cellForRowAt: index1) as? DataTableviewCell
        XCTAssertNotNil(cell1?.titleLabel.text)

        let index2 = IndexPath(row: 2, section: 0)
        let cell2 = dataController.tableView(dataController.tableView, cellForRowAt: index2) as? DataTableviewCell
        XCTAssertNotNil(cell2?.titleLabel.text)
    }
}
