//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Abdo on 14.06.21.
//

import Foundation
import UIKit

private let cornerRadius: CGFloat = 15
private let lightShadowRadius: CGFloat = 6.25
private let darkShadowRadius: CGFloat = 5.5

class PokemonCell: UICollectionViewCell {
	// MARK: - Private Properties

	private let pokeImage: UIImageView = {
		let img = UIImageView()
		img.translatesAutoresizingMaskIntoConstraints = false
		img.layer.borderColor = UIColor.black.cgColor
		img.contentMode = .scaleAspectFit
		img.setContentHuggingPriority(.defaultLow, for: .vertical)
		img.clipsToBounds = true
		return img
	}()

	private let idLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.textAlignment = .left
		lbl.numberOfLines = 0
		lbl.font = UIFont.boldSystemFont(ofSize: 25)
		return lbl
	}()

	private let nameLabel: UILabel = {
		let lbl = UILabel()
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.textAlignment = .center
		lbl.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		return lbl
	}()

	private let view: UIView = {
		let v = UIView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.layer.cornerRadius = cornerRadius
		return v
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

	// MARK: - Public Properties

	public var pokemon: Pokemon? {
		didSet {
			guard let pokemon = pokemon else { return }
			idLabel.text = "\(pokemon.id)"
			nameLabel.text = pokemon.name
			pokeImage.load(url: pokemon.imageURL)
		}
	}

	public var image: UIImage? {
		didSet {
			if let image = image {
				pokeImage.image = image
			}
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		view.frame = contentView.bounds
		lightShadow.frame = view.bounds
		darkShadow.frame = view.bounds

		contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: cornerRadius).cgPath
		view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
		darkShadow.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
		lightShadow.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
	}

	private func setupUI() {
		layer.cornerRadius = cornerRadius
		contentView.clipsToBounds = false
		contentView.layer.cornerRadius = cornerRadius
		contentView.addSubview(view)

		view.addSubview(pokeImage)
		view.addSubview(idLabel)
		view.addSubview(nameLabel)

		view.layer.insertSublayer(darkShadow, at: 0)
		view.layer.insertSublayer(lightShadow, at: 0)

		darkShadow.backgroundColor = UIColor.bgColor.cgColor
		lightShadow.backgroundColor = UIColor.bgColor.cgColor

		if traitCollection.userInterfaceStyle == .dark {
			setDarkShadows()
		} else {
			setLightShadows()
		}

//		setInnerShadow()
		setupConstraints()
	}

	private func setDarkShadows() {
		darkShadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.05).cgColor
		darkShadow.shadowOffset = CGSize(width: -0.01, height: -0.01)
		darkShadow.shadowRadius = darkShadowRadius

		lightShadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
		lightShadow.shadowOffset = CGSize(width: 3, height: 3)
		lightShadow.shadowRadius = darkShadowRadius
	}

	private func setLightShadows() {
		darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		darkShadow.shadowOffset = CGSize(width: 10, height: 10)
		darkShadow.shadowRadius = lightShadowRadius

		lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.7).cgColor
		lightShadow.shadowOffset = CGSize(width: -5, height: -5)
		lightShadow.shadowRadius = lightShadowRadius
	}

	private func setupConstraints() {
//		let widthConstant: CGFloat = 5
//		let heightConstant: CGFloat = 10
//		view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: heightConstant).isActive = true
//		view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -heightConstant).isActive = true
//		view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthConstant).isActive = true
//		view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -widthConstant).isActive = true

		view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

		idLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
		idLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		idLabel.leadingAnchor.constraint(equalTo: pokeImage.leadingAnchor, constant: 2).isActive = true
		idLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true

		pokeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
		pokeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
		pokeImage.topAnchor.constraint(equalTo: idLabel.bottomAnchor).isActive = true
		pokeImage.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5).isActive = true

		nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
		nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
		nameLabel.leadingAnchor.constraint(equalTo: pokeImage.leadingAnchor).isActive = true
		nameLabel.trailingAnchor.constraint(equalTo: pokeImage.trailingAnchor).isActive = true
	}

	private func setInnerShadow() {
		let firstOverlay = UIView()
		firstOverlay.frame = view.bounds
		firstOverlay.layer.borderWidth = 7
		firstOverlay.layer.borderColor = UIColor.gray.cgColor
		firstOverlay.layer.cornerRadius = 15

		let secondOverlay = UIView()
		secondOverlay.frame = view.bounds
		secondOverlay.layer.borderWidth = 7
		secondOverlay.layer.borderColor = UIColor.white.cgColor
		secondOverlay.layer.cornerRadius = 15

		let layerGradient = CAGradientLayer()
		layerGradient.colors = [UIColor.gray.cgColor, UIColor.clear.cgColor]
		layerGradient.startPoint = CGPoint(x: 0, y: 0)
		layerGradient.endPoint = CGPoint(x: 1, y: 1)
		layerGradient.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)

		let layerGradient2 = CAGradientLayer()
		layerGradient2.colors = [UIColor.gray.cgColor, UIColor.clear.cgColor]
		layerGradient2.startPoint = CGPoint(x: 1, y: 1)
		layerGradient2.endPoint = CGPoint(x: 0, y: 0)
		layerGradient2.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)

		let firstMask = UIView()
		firstMask.layer.addSublayer(layerGradient)
		firstOverlay.mask = firstMask

		let secondMask = UIView()
		secondMask.layer.addSublayer(layerGradient2)
		secondOverlay.mask = secondMask

		contentView.addSubview(firstOverlay)
		contentView.addSubview(secondOverlay)
	}
	
	deinit {
		print("deinit")
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// let start = self.imageView.center
//
// UIView.animateKeyframes(withDuration: 5, delay: 0, options: .calculationModeCubic, animations: {
//	UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
//		self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
//	}
//
//	UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
//		self.imageView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY)
//	}
//
//	UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
//		self.imageView.center = CGPoint(x: self.view.bounds.width, y: start.y)
//	}
//
//	UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
//		self.imageView.center = start
//	}
// })
