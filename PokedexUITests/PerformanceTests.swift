//
//  PerformanceTests.swift
//  PokedexUITests
//
//  Created by Abdo on 16.07.22.
//

import XCTest

class PerformanceTests: XCTestCase {
	func testLaunchPerformance() throws {
		if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
			// This measures how long it takes to launch your application.
			measure(metrics: [XCTApplicationLaunchMetric()]) {
				XCUIApplication().launch()
			}
		}
	}
}
