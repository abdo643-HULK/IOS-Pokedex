//
//  TabButton.swift
//  Pokedex
//
//  Created by Abdo on 25.06.21.
//

import UIKit
import Foundation

class TabButton: UIButton {
	public var isActive: Bool = false
}

final class StatButton: UIButton {
	public var type: StatType = .base

	public var isActive: Bool = false {
		didSet {
			self.setTitleColor(isActive ? .bgColor : color, for: .normal)
			self.backgroundColor = isActive ? color  : .bgColor
		}
	}

	public var color: UIColor = .bgColor {
		didSet {
			self.setTitleColor(isActive ? .bgColor : color, for: .normal)
			self.backgroundColor = isActive ? color  : .bgColor
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .bgColor
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		self.layer.cornerRadius = self.bounds.width * 0.2
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
