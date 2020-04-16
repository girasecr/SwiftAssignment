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
    var tempImageUrl: String = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
    
    //**************************************************
    // MARK: Test Cases Life Cycle
    //**************************************************
    override func setUp() {
        profileImageView = UIImageView()
    }
    
    override func tearDown() {
         super.tearDown()
    }
    
    func testSetImage() {
        XCTAssertNotNil(tempImageUrl)
        let imageURL = URL(string: tempImageUrl)
        
        XCTAssertNotNil(imageURL)
        let placeholderImage = UIImage(named: "defaultthumb.png")
        XCTAssertNotNil(placeholderImage)
        
        self.profileImageView.af.setImage(withURL: imageURL!, placeholderImage: placeholderImage)
        XCTAssertNotNil(self.profileImageView.image)
    }
}
