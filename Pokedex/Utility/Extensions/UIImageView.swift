//
//  UIImageView.swift
//  Pokedex
//
//  Created by Abdo on 19.06.21.
//

import Foundation
import UIKit

extension UIImageView {
	func load(url: URL) {
		Task {
			do {
				let (data, _) = try await URLSession.shared.data(from: url)
				if let image = UIImage(data: data) {
					self.image = image
				}
			} catch {
				print(error.localizedDescription)
			}
		}
	}
}
