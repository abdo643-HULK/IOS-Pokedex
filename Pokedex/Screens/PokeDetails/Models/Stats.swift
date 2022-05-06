//
//  Stats.swift
//  Pokedex
//
//  Created by Abdo on 17.06.21.
//

import Foundation

// MARK: - Properties

struct Stats: Codable {
	let hp: UInt16
	let attack: UInt16
	let defense: UInt16
	let speed: UInt16
	let specialAttack: UInt16
	let specialDefense: UInt16

	public lazy var biggestStat: UInt16 = {
		return [hp, attack, defense, speed, specialDefense, specialAttack].max() ?? attack + 1
	}()

	public lazy var total: UInt16 = {
		hp + attack + defense + speed + specialAttack + specialDefense
	}()
}

// MARK: - Init

extension Stats {
	init(with to: UInt16) {
		hp = to
		attack = to
		defense = to
		speed = to
		specialAttack = to
		specialDefense = to
	}
}

// struct Stat {
//	let base: UInt8
//
//	var max: UInt16 {
//		let newBase = Double(2 * base + 94 + 5)
//		let res: UInt16 = UIn16(floor(newBase * 1.1))
//		return res
//	}
//
//	var min: UInt16 {
//		let baseDouble = Double(2 * base)
//		let firstFloor = floor(baseDouble + 5.0)
//		let res: UInt16 = floor(firstFloor * 0.9)
//		return res
//	}
// }
