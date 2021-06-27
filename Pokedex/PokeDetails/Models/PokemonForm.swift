//
//  PokemonForm.swift
//  Pokedex
//
//  Created by Abdo on 24.06.21.
//

import Foundation

struct PokemonForm {
	let id: UInt16
	let name: String
	let imageURL: URL
	let height: Float16
	let weight: Float16
	let types: [String]
	let abilities: [Ability]
	let baseStats: Stats
	let formName: String
}
