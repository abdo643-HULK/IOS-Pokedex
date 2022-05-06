//
//  GoogleSignInButton.swift
//  Pokedex
//
//  Created by Abdo on 03.07.21.
//

import UIKit
import Foundation

class GoogleSignInButton: UIButton {
	private let imageBox: UIImageView = {
		let img = UIImageView()

		return img
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.clipsToBounds = true
		self.layer.cornerRadius = 15
		self.setTitle("Sign in with Google", for: .normal)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
