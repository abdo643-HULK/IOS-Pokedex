//
//  PokemonGenerations.swift
//  Pokedex
//
//  Created by Abdo on 25.06.21.
//

import Foundation

enum PokeGenerations: Int, CaseIterable {
	case gen1 = 0
	case gen2 = 1
	case gen3 = 2
	case gen4 = 3
	case gen5 = 4
	case gen6 = 5
	case gen7 = 6
	case gen8 = 7

	var name: String {
		switch self {
			case .gen1:
				return "generation-i"
			case .gen2:
				return "generation-ii"
			case .gen3:
				return "generation-iii"
			case .gen4:
				return "generation-iv"
			case .gen5:
				return "generation-v"
			case .gen6:
				return "generation-vi"
			case .gen7:
				return "generation-vii"
			case .gen8:
				return "generation-viii"
		}
	}
}
