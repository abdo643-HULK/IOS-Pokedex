//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Abdo on 17.06.21.
//

import Foundation

struct PokemonDetails {
	let id: UInt16
	let name: String
	let imageURL: URL
	let height: Float16
	let weight: Float16
	let types: [String]
	let abilities: [Ability]
	let baseStats: Stats
	let generation: String?
	let isLegendary: Bool?
	let isMythical: Bool?
	let captureRate: UInt8?
	let isFormSwitchable: Bool?
	let hasGenderDiff: Bool?
	let genderRate: GenderRates?
	let evoltutions: [Evolution?]
	let forms: [PokemonForm]

	// always calc for lvl 100
	lazy var maxStats: Stats = {
		let maxHp: UInt16 = id == 292 ? 1 : calcMaxHP()
		let maxAttack: UInt16 = calcMaxStat(stat: baseStats.attack)
		let maxDefense: UInt16 = calcMaxStat(stat: baseStats.defense)
		let maxSpeed: UInt16 = calcMaxStat(stat: baseStats.speed)
		let maxspecialAttack: UInt16 = calcMaxStat(stat: baseStats.specialAttack)
		let maxSpecialDefense: UInt16 = calcMaxStat(stat: baseStats.specialDefense)

		return Stats(
			hp: maxHp,
			attack: maxAttack,
			defense: maxDefense,
			speed: maxSpeed,
			specialAttack: maxspecialAttack,
			specialDefense: maxSpecialDefense
		)
	}()

	lazy var minStats: Stats = {
		let minHp: UInt16 = id == 292 ? 1 : calcMinHP()
		let minAttack: UInt16 = calcMinStat(stat: baseStats.attack)
		let minDefense: UInt16 = calcMinStat(stat: baseStats.defense)
		let minSpeed: UInt16 = calcMinStat(stat: baseStats.speed)
		let minspecialAttack: UInt16 = calcMinStat(stat: baseStats.specialAttack)
		let minSpecialDefense: UInt16 = calcMinStat(stat: baseStats.specialDefense)

		return Stats(
			hp: minHp,
			attack: minAttack,
			defense: minDefense,
			speed: minSpeed,
			specialAttack: minspecialAttack,
			specialDefense: minSpecialDefense
		)
	}()

	private func calcMaxHP() -> UInt16 {
		let s = Double(2 * baseStats.hp + 94)
		let n = floor(s + 110.0)
		return UInt16(n)
	}

	private func calcMinHP() -> UInt16 {
		let s = Double(2 * baseStats.hp)
		let n: Double = floor(s + 110.0)
		return UInt16(n)
	}

	private func calcMaxStat(stat: UInt16) -> UInt16 {
		let newBase = Double(2 * stat + 94 + 5)
		let res = UInt16(floor(newBase * 1.1))
		return res
	}

	private func calcMinStat(stat: UInt16) -> UInt16 {
		let baseDouble = Double(2 * stat)
		let firstFloor = floor(baseDouble + 5.0)
		let res = UInt16(floor(firstFloor * 0.9))
		return res
	}
}
