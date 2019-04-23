//
//  ShareAndSkiTests.swift
//  ShareAndSkiTests
//
//  Created by karol.nadratowaski on 11/04/2019.
//  Copyright © 2019 Apolej Developer. All rights reserved.
//

import XCTest
@testable import ShareAndSki

class ShareAndSkiTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialCreator() {
        // 1. given
        let name = "Karol Nadratowski"
        // 2. when
        let initials = InitialCreator.getInitials(from: name)
        // 3. then
        XCTAssertEqual(initials, "KN")
        
    }

    func testInitialCreatorWithoutLastName() {
        // 1. given
        let name = "Karol"
        // 2. when
        let initials = InitialCreator.getInitials(from: name)
        // 3. then
        XCTAssertEqual(initials, "K")

    }

    func testInitialCreatorWithoutFirstAndLastName() {
        // 1. given
        let name = ""
        // 2. when
        let initials = InitialCreator.getInitials(from: name)
        // 3. then
        XCTAssertEqual(initials, "")

    }

    func testInitialCreatorWithOnlySpace() {
        // 1. given
        let name = " "
        // 2. when
        let initials = InitialCreator.getInitials(from: name)
        // 3. then
        XCTAssertEqual(initials, "")

    }

    func testInitialCreatorWithThreeName() {
        // 1. given
        let name = "Karol Edward Nadratowski"
        // 2. when
        let initials = InitialCreator.getInitials(from: name)
        // 3. then
        XCTAssertEqual(initials, "KN")

    }


}
