//
//  PokemonBox.swift
//  Pokedex
//
//  Created by Abdo on 25.06.21.
//

import UIKit
import Foundation

private let cornerRadius: CGFloat = 20
private let lightShadowRadius: CGFloat = 6
private let darkShadowRadius: CGFloat = 6

final class PokemonBoxView: UIView {
	public var name: String? {
		didSet {
			nameLabel.text = name
		}
	}

	public var imageURL: URL? {
		didSet {
			guard let imageURL = imageURL else {
				return
			}
			pokeImage.load(url: imageURL)
		}
	}

	public var types: [String]? {
		didSet {
			self.setupTypes()
		}
	}

	private let nameLabel: UILabel = {
		let lbl = UILabel()
		lbl.layer.masksToBounds = true
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.numberOfLines = 1
		lbl.textAlignment = .center
		lbl.layer.cornerRadius = cornerRadius
		lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 40, weight: .bold))
		return lbl
	}()

	private let pokeImage: UIImageView = {
		let img = UIImageView()
		img.translatesAutoresizingMaskIntoConstraints = false
		img.layer.borderColor = UIColor.black.cgColor
		img.contentMode = .scaleAspectFit
		img.clipsToBounds = true
		return img
	}()

	private let typesStack: UIStackView = {
		let s = UIStackView()
		s.clipsToBounds = true
		s.translatesAutoresizingMaskIntoConstraints = false
		s.axis = .horizontal
		s.layer.cornerRadius = 15
		s.distribution = .fillEqually
		return s
	}()

	private let darkShadow: CALayer = {
		let darkShadow = CALayer()
		darkShadow.cornerRadius = cornerRadius
		darkShadow.shadowOpacity = 1
		return darkShadow
	}()

	private let lightShadow: CALayer = {
		let lightShadow = CALayer()
		lightShadow.cornerRadius = cornerRadius
		lightShadow.shadowOpacity = 1
		return lightShadow
	}()

	public func setupView() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.layer.cornerRadius = cornerRadius

		self.addSubview(nameLabel)
		self.addSubview(pokeImage)
		self.addSubview(typesStack)

		self.layer.insertSublayer(darkShadow, at: 0)
		self.layer.insertSublayer(lightShadow, at: 0)

		darkShadow.backgroundColor = UIColor.bgColor.cgColor
		lightShadow.backgroundColor = UIColor.bgColor.cgColor

		if traitCollection.userInterfaceStyle == .dark {
			setDarkShadows()
		} else {
			setLightShadows()
		}

		setupConstraints()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		lightShadow.frame = bounds
		darkShadow.frame = bounds

		self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
		darkShadow.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
		lightShadow.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
	}

	private func setupTypes() {
		guard let types = types else {
			return
		}

		let firstType = UILabel()
		firstType.text = types.first?.capitalizingFirstLetter()
		firstType.backgroundColor = PokeType(rawValue: types.first?.description ?? "")?.color ?? PokeType.Unkown.color
		firstType.textAlignment = .center
		firstType.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .bold))

		if types.count == 1 {
			typesStack.addArrangedSubview(firstType)
			return
		}

		let secondType = UILabel()
		secondType.text = types.last?.capitalizingFirstLetter()
		secondType.backgroundColor = PokeType(rawValue: types.last?.description ?? "")?.color ?? PokeType.Unkown.color
		secondType.textAlignment = .center
		secondType.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .bold))

		typesStack.addArrangedSubview(firstType)
		typesStack.addArrangedSubview(secondType)
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			nameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
			nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
			nameLabel.heightAnchor.constraint(equalToConstant: 30),

			pokeImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
			pokeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -55),
			pokeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			pokeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),

			typesStack.topAnchor.constraint(equalTo: pokeImage.bottomAnchor),
			typesStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
			typesStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
			typesStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

		])
	}

	private func setDarkShadows() {
		darkShadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.05).cgColor
		darkShadow.shadowOffset = CGSize(width: -0.05, height: -0.05)
		darkShadow.shadowRadius = darkShadowRadius

		lightShadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.6).cgColor
		lightShadow.shadowOffset = CGSize(width: 3, height: 3)
		lightShadow.shadowRadius = darkShadowRadius
	}

	private func setLightShadows() {
		darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		darkShadow.shadowOffset = CGSize(width: 5, height: 5)
		darkShadow.shadowRadius = lightShadowRadius

		lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.5).cgColor
		lightShadow.shadowOffset = CGSize(width: -4, height: -2)
		lightShadow.shadowRadius = lightShadowRadius
	}
}
