//
//  PokedexTests.swift
//  PokedexTests
//
//  Created by Abdo on 12.07.22.
//

import XCTest
@testable import Pokedex

class PokedexTests: XCTestCase {
	var stats: Stats!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		stats = Stats(hp: 1, attack: 1, defense: 1, speed: 1, specialAttack: 2, specialDefense: 1)
	}

	func testStatsTotal() {
		XCTAssertTrue(stats.total == 7)
		XCTAssertFalse(stats.total != 7)
	}

	func testStatsBiggest() {
		XCTAssertTrue(stats.biggestStat == 2)
		XCTAssertFalse(stats.biggestStat != 2)
	}
	
}
