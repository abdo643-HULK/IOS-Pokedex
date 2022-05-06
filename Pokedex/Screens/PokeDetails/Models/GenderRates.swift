//
//  GenderRates.swift
//  Pokedex
//
//  Created by Abdo on 17.06.21.
//

import Foundation

struct GenderRates: Codable {
	public var male: Float16 = 0
	public var female: Float16 = 0
	public var isGenderLess: Bool = false

	init(rate: Int8) {
		switch rate {
			case -1:
				isGenderLess = true
			case 0:
				male = 100
				female = 0
			case 1:
				male = 87.5
				female = 12.5
			case 2:
				male = 75
				female = 25
			case 3:
				male = 62.5
				female = 37.5
			case 4:
				male = 50
				female = 50
			case 5:
				male = 37.5
				female = 62.5
			case 6:
				male = 25
				female = 75
			case 7:
				male = 12.5
				female = 87.5
			case 8:
				male = 0
				female = 100
			default:
				break
		}
	}
}
