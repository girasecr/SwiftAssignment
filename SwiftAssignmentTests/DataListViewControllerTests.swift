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

    var dataController: DataListViewController!
    
    override func setUp() {
        super.setUp()
        
        self.dataController = DataListViewController()
        self.dataController.loadView()
        self.dataController.viewDidLoad()
        _ = Darwin.wait(w_status: 10)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
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
}
