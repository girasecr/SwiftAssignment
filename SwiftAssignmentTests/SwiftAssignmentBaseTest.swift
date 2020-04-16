//
//  SwiftAssignmentBaseTest.swift
//  SwiftAssignmentTests
//
//  Created by Chetan Girase on 16/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest
@testable import SwiftAssignment

let kTimeOut = 10.0

class SwiftAssignmentBaseTest: XCTestCase {

    //**************************************************
    // MARK: Test Cases Life Cycle
    //**************************************************
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    //**************************************************
    // MARK: Load API Data from the Local JSON file instead of going to the Back-End
    //**************************************************
    func getAPIData(forResource: String, ofType: String, completion: @escaping(Data?, Error?) -> Void) {
        let testBundle = Bundle(for: type(of: self))

        if let path = testBundle.path(forResource: forResource, ofType: ofType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        } else {
            completion(nil, nil)
        }
    }

    func getModelData(forResource: String, ofType: String, completion: @escaping(Data?, Error?) -> Void) {
        getAPIData(forResource: forResource, ofType: ofType, completion: completion)
    }

    //**************************************************
    // MARK: Common Methods
    //**************************************************
    func testCheckAPIResponse(urlRequest: URLRequest) {
        let expectation = XCTestExpectation(description: "Connect to API Server")
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, _) in
            XCTAssertNotNil(data, "No data was downloaded.")
            expectation.fulfill()
        }
        dataTask.resume()
        wait(for: [expectation], timeout: kTimeOut)
    }

    func testGetResponse(url: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }.resume()
    }
}
