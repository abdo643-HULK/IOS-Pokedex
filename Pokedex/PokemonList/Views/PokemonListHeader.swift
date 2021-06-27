//
//  PokemonListHeader.swift
//  Pokedex
//
//  Created by Abdo on 22.06.21.
//

import Foundation
import UIKit

private let cornerRadius: CGFloat = 10
private let lightShadowRadius: CGFloat = 6.25
private let darkShadowRadius: CGFloat = 5.5

final class PokemonListHeader: UICollectionReusableView {
	public var generation: String? {
		didSet {
			headerLabel.text = generation
		}
	}

	private let view: UIView = {
		let v = UIView()
		v.translatesAutoresizingMaskIntoConstraints = false
		v.layer.cornerRadius = cornerRadius
		return v
	}()

	private let headerLabel: UILabel = {
		let lbl = UILabel()
		lbl.layer.masksToBounds = true
		lbl.translatesAutoresizingMaskIntoConstraints = false
		lbl.numberOfLines = 1
		lbl.textAlignment = .center
		lbl.layer.cornerRadius = cornerRadius
		lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 30, weight: .bold))
		return lbl
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

	override init(frame: CGRect) {
		super.init(frame: frame)
		layer.cornerRadius = cornerRadius
		addSubview(view)
		
		view.addSubview(headerLabel)
		view.layer.insertSublayer(darkShadow, at: 0)
		view.layer.insertSublayer(lightShadow, at: 0)

		let constant: CGFloat = 20
		NSLayoutConstraint.activate([
			view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: constant),
			view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -constant),
			view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
			view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

			headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			headerLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
		])

		darkShadow.backgroundColor = UIColor.bgColor.cgColor
		lightShadow.backgroundColor = UIColor.bgColor.cgColor

		if traitCollection.userInterfaceStyle == .dark {
			setDarkShadows()
		} else {
			setLightShadows()
		}
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		lightShadow.frame = view.bounds
		darkShadow.frame = view.bounds

		view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
		darkShadow.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
		lightShadow.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
	}

	private func setDarkShadows() {
//		darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
//		darkShadow.shadowOffset = CGSize(width: -5, height: -5)
//		darkShadow.shadowRadius = darkShadowRadius
//
//		lightShadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
//		lightShadow.shadowOffset = CGSize(width: 3, height: 3)
//		lightShadow.shadowRadius = darkShadowRadius

		darkShadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.05).cgColor
		darkShadow.shadowOffset = CGSize(width: -0.05, height: -0.05)
		darkShadow.shadowRadius = darkShadowRadius

		lightShadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.6).cgColor
		lightShadow.shadowOffset = CGSize(width: 3, height: 3)
		lightShadow.shadowRadius = darkShadowRadius
	}

	private func setLightShadows() {
		darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		darkShadow.shadowOffset = CGSize(width: 10, height: 10)
		darkShadow.shadowRadius = lightShadowRadius

		lightShadow.shadowColor = UIColor.white.withAlphaComponent(0.7).cgColor
		lightShadow.shadowOffset = CGSize(width: -1, height: -1)
		lightShadow.shadowRadius = lightShadowRadius
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
