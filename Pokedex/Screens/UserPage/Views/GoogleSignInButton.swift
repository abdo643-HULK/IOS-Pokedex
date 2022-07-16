//
//  GoogleSignInButton.swift
//  Pokedex
//
//  Created by Abdo on 03.07.21.
//

import UIKit
import Foundation

final class GoogleSignInButton: UIButton {
	override init(frame: CGRect) {
		super.init(frame: frame)

		let googleColor = UIColor(named: "GoogleButton")!
		let googleNormal = UIImage(named: "Google")!

		self.clipsToBounds = true
		self.layer.cornerRadius = 10

		self.backgroundColor = googleColor
		self.setTitle("Sign in with Google", for: .normal)
		self.setTitleColor(.black, for: .normal)
		self.titleLabel?.font = UIFont(name: "Roboto-Medium", size: 20)

		self.imageView?.backgroundColor = googleColor
		self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 50)
		self.setImage(googleNormal, for: .normal)
//		self.setImage(googleNormal, for: .highlighted)
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
