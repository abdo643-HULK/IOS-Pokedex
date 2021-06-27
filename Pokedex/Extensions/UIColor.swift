//
//  UIcolorHex.swift
//  Pokedex
//
//  Created by Abdo on 16.06.21.
//

import UIKit
import Foundation

public extension UIColor {
	static let bgColor = UIColor(named: "BackgroundColor") ?? offWhite
	static let offWhite = UIColor(red: 225 / 255, green: 225 / 255, blue: 235 / 255, alpha: 1)
	static let offBlack = UIColor(red: 14 / 255, green: 14 / 255, blue: 22 / 255, alpha: 1)

	convenience init?(hex: String) {
		let r, g, b, a: CGFloat

		let start = hex.hasPrefix("#") ? hex.index(hex.startIndex, offsetBy: 1) : hex.index(hex.startIndex, offsetBy: 0)
		let hexColor = String(hex[start...])

		if hexColor.count == 6 {
			let scanner = Scanner(string: hexColor)
			var hexNumber: UInt64 = 0

			if scanner.scanHexInt64(&hexNumber) {
				r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
				g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
				b = CGFloat(hexNumber & 0x0000FF) / 255

				self.init(red: r, green: g, blue: b, alpha: 1)
				return
			}
		}

		if hexColor.count == 8 {
			let scanner = Scanner(string: hexColor)
			var hexNumber: UInt64 = 0

			if scanner.scanHexInt64(&hexNumber) {
				r = CGFloat((hexNumber & 0xFF00_0000) >> 24) / 255
				g = CGFloat((hexNumber & 0x00FF_0000) >> 16) / 255
				b = CGFloat((hexNumber & 0x0000_FF00) >> 8) / 255
				a = CGFloat(hexNumber & 0x0000_00FF) / 255

				self.init(red: r, green: g, blue: b, alpha: a)
				return
			}
		}

		return nil
	}

	convenience init(hex: Int) {
		self.init(
			red: CGFloat((hex >> 16) & 0xFF),
			green: CGFloat((hex >> 8) & 0xFF),
			blue: CGFloat(hex & 0xFF),
			alpha: CGFloat(1.0)
		)
	}
}
