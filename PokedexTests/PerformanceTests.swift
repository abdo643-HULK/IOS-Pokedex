//
//  PerformanceTest.swift
//  PokedexTests
//
//  Created by Abdo on 16.07.22.
//

import XCTest
@testable import Pokedex

class PerformanceTest: XCTestCase {
	var stats: Stats!
	override func setUp() {
		stats = Stats(hp: 1, attack: 1, defense: 1, speed: 1, specialAttack: 1, specialDefense: 1)
	}
	
	func testStatsTotalPerformance() {
		measure(
			metrics: [XCTClockMetric(), XCTCPUMetric(), XCTMemoryMetric()]
		) {
			stats.total
		}
	}
	
	func testStatsBiggestStatPerformance() {
		var stats = Stats(hp: 1, attack: 1, defense: 1, speed: 1, specialAttack: 1, specialDefense: 1)
		measure(
			metrics: [XCTClockMetric(), XCTCPUMetric(), XCTMemoryMetric()]
		) {
			stats.biggestStat
		}
	}
}
