//
//  Evolution.swift
//  Pokedex
//
//  Created by Abdo on 24.06.21.
//

import Foundation

struct Evolution {
	let name: String
	let previousEvolution: UInt16?
	let trigger: Evolutiontrigger?
	let minLvl: UInt8?
	let neededItem: String?
	let neededTime: String?
	let neededLocation: String?
	let neededHappiness: UInt16?
	let neededAffection: UInt16?
	let needsRain: Bool
}
