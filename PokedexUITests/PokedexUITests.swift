//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Abdo on 12.07.22.
//

import XCTest

class PokedexUITests: XCTestCase {
	var app: XCUIApplication!

    override func setUp() {
		super.setUp()
		continueAfterFailure = false
		app = XCUIApplication()
		app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		app = nil
	}
	
	func testPokedetails() {
		let charmanderCell = app.collectionViews.children(matching: .cell).element(boundBy: 3).children(matching: .other).element
		XCTAssertTrue(charmanderCell.waitForExistence(timeout: 10))
		charmanderCell.tap()
	}
}
