//
//  Types.swift
//
//
//  Created by Abdo on 16.06.21.
//

import UIKit
import Foundation

enum PokeType: String {
	case Normal = "normal"
	case Fire = "fire"
	case Water = "water"
	case Electric = "electric"
	case Grass = "grass"
	case Ice = "ice"
	case Fighting = "fighting"
	case Poison = "poison"
	case Ground = "ground"
	case Flying = "flying"
	case Psychic = "psychic"
	case Bug = "bug"
	case Rock = "rock"
	case Ghost = "ghost"
	case Dragon = "dragon"
	case Dark = "dark"
	case Steel = "steel"
	case Fairy = "fairy"
	case Shadow = "shadow"
	case Unkown = "unknown"

	var color: UIColor {
		switch self {
		case .Normal:
			return UIColor(hex: "#A8A77A")!
		case .Fire:
			return UIColor(hex: "#EE8130")!
		case .Water:
			return UIColor(hex: "#6390F0")!
		case .Electric:
			return UIColor(hex: "#F7D02C")!
		case .Grass:
			return UIColor(hex: "#7AC74C")!
		case .Ice:
			return UIColor(hex: "#96D9D6")!
		case .Fighting:
			return UIColor(hex: "#C22E28")!
		case .Poison:
			return UIColor(hex: "#A33EA1")!
		case .Ground:
			return UIColor(hex: "#E2BF65")!
		case .Flying:
			return UIColor(hex: "#A98FF3")!
		case .Psychic:
			return UIColor(hex: "#F95587")!
		case .Bug:
			return UIColor(hex: "#A6B91A")!
		case .Rock:
			return UIColor(hex: "#B6A136")!
		case .Ghost:
			return UIColor(hex: "#735797")!
		case .Dragon:
			return UIColor(hex: "#6F35FC")!
		case .Dark:
			return UIColor(hex: "#705746")!
		case .Steel:
			return UIColor(hex: "#B7B7CE")!
		case .Fairy:
			return UIColor(hex: "#D685AD")!
		case .Shadow:
			return UIColor(hex: "#000000")!
		case .Unkown:
			return .bgColor
		}
	}
}
