//
//  DataTableviewCellTests.swift
//  SwiftAssignmentTests
//
//  Created by Chetan Girase on 16/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import XCTest
@testable import SwiftAssignment

class DataTableviewCellTests: XCTestCase {
    var profileImageView: UIImageView!
    var tempImageUrl: String = "https://i49.photobucket.com/albums/f260/starfoxfan/fursona.jpg"

    //**************************************************
    // MARK: Test Cases Life Cycle
    //**************************************************
    override func setUp() {
        profileImageView = UIImageView()
    }

    override func tearDown() {
         super.tearDown()
    }

    func testSetImageWithValidUrl() {
        XCTAssertNotNil(tempImageUrl)
        let imageURL = URL(string: tempImageUrl)
        XCTAssertNotNil(imageURL)
        let placeholderImage = UIImage(named: "defaultthumb.png")
        XCTAssertNotNil(placeholderImage)
        self.profileImageView.af.setImage(withURL: imageURL!, placeholderImage: placeholderImage)
        XCTAssertNotNil(self.profileImageView.image)
    }

    func testSetImageWithInvalidUrl() {
        let invalidUrl = "https://testinvalidurl"
        XCTAssertNotNil(invalidUrl)
        let imageURL = URL(string: invalidUrl)
        XCTAssertNotNil(imageURL)
        let placeholderImage = UIImage(named: "defaultthumb.png")
        XCTAssertNotNil(placeholderImage)
        self.profileImageView.af.setImage(withURL: imageURL!, placeholderImage: placeholderImage)
        XCTAssertNotNil(self.profileImageView.image)
    }
}
