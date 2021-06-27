//
//  Pokemon.swift
//  Pokedex
//
//  Created by Abdo on 14.06.21.
//

import Foundation

struct Pokemon {
	public let id: UInt16
	public let name: String
	public let imageURL: URL

	init(id: UInt16, name: String) {
		self.id = id
		self.name = name
		self.imageURL = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")!
	}
}
