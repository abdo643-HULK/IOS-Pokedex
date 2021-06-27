//
//  StatsView.swift
//  Pokedex
//
//  Created by Abdo on 24.06.21.
//

import UIKit
import Foundation

enum StatType: String, CaseIterable {
	case base = "Base"
	case min = "Min"
	case max = "Max"
}

private let cornerRadius: CGFloat = 20

final class StatsView: UIView {
	public var color: UIColor = .bgColor {
		didSet {
			statsButtons.forEach {
				$0.color = color
			}
			statsBars.forEach {
				$0.color = color
			}
		}
	}

	public var minStats = Stats(with: 1)
	public var maxStats = Stats(with: 1)

	public var basetats = Stats(with: 1) {
		didSet {
			statsBars[0].progress = CGFloat(basetats.hp) / CGFloat(basetats.biggestStat)
			statsBars[1].progress = CGFloat(basetats.attack) / CGFloat(basetats.biggestStat)
			statsBars[2].progress = CGFloat(basetats.defense) / CGFloat(basetats.biggestStat)
			statsBars[3].progress = CGFloat(basetats.speed) / CGFloat(basetats.biggestStat)
			statsBars[4].progress = CGFloat(basetats.specialAttack) / CGFloat(basetats.biggestStat)
			statsBars[5].progress = CGFloat(basetats.specialDefense) / CGFloat(basetats.biggestStat)

			statsBars[0].value = basetats.hp
			statsBars[1].value = basetats.attack
			statsBars[2].value = basetats.defense
			statsBars[3].value = basetats.speed
			statsBars[4].value = basetats.specialAttack
			statsBars[5].value = basetats.specialDefense
		}
	}

	private let selectBar: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .horizontal
		stack.distribution = .fillEqually
		stack.spacing = 10
		return stack
	}()

	private let statsButtons: [StatButton] = {
		var btnArray = [StatButton](repeating: StatButton(), count: 3)
		for (i, item) in StatType.allCases.enumerated() {
			let btn = StatButton()
			btn.setTitle(item.rawValue, for: .normal)
			btn.translatesAutoresizingMaskIntoConstraints = false
			btn.type = item
			btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
			btn.addTarget(self, action: #selector(changeStat(_:)), for: .touchUpInside)
			btnArray[i] = btn
		}

		btnArray[0].isActive = true

		return btnArray
	}()

	private let statsStack: UIStackView = {
		let stack = UIStackView()
		stack.translatesAutoresizingMaskIntoConstraints = false
		stack.axis = .vertical
		stack.distribution = .fill
		stack.spacing = 10
		return stack
	}()

	private let statsNames: [UILabel] = {
		var lblArray = [UILabel](repeating: UILabel(), count: 6)
		for (i, statName) in ["HP", "ATTACK", "DEFENSE", "SPEED", "SPECIAL-ATTACK", "SPECIAL-DEFENSE"].enumerated() {
			let lbl = UILabel()
			lbl.translatesAutoresizingMaskIntoConstraints = false
			lbl.text = statName
			lbl.textAlignment = .center
			lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .bold))
			lblArray[i] = lbl
		}
		return lblArray
	}()

	private let statsBars: [StatsProgressBar] = {
		let bars: [StatsProgressBar] = (0 ... 6).map { _ -> StatsProgressBar in
			let bar = StatsProgressBar()
			bar.translatesAutoresizingMaskIntoConstraints = true
			bar.backgroundColor = .gray.withAlphaComponent(0.3)
			bar.color = .bgColor
			return bar
		}

		return bars
	}()

	public func setupView() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.layer.cornerRadius = cornerRadius

		self.addSubview(selectBar)
		self.addSubview(statsStack)

		setupSelectBar()
		setupStatsStack()

		setupConstraints()
	}

	private func setupSelectBar() {
		statsButtons.forEach {
			selectBar.addArrangedSubview($0)
		}
	}

	private func setupStatsStack() {
		for (i, statLbl) in statsNames.enumerated() {
			let bar = statsBars[i]

			let stack = UIStackView()
			stack.axis = .vertical
			stack.setCustomSpacing(10, after: statLbl)
			stack.alignment = .fill

			stack.addArrangedSubview(statLbl)
			stack.addArrangedSubview(bar)

			statsStack.addArrangedSubview(stack)

			NSLayoutConstraint.activate([
				statLbl.heightAnchor.constraint(equalToConstant: 40),

				bar.heightAnchor.constraint(equalToConstant: 30),
			])
		}
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			selectBar.topAnchor.constraint(equalTo: self.topAnchor),
			selectBar.heightAnchor.constraint(equalToConstant: 50),
			selectBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			selectBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),

			statsStack.topAnchor.constraint(equalTo: selectBar.bottomAnchor),
			statsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			statsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			statsStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		])
	}

	@objc
	private func changeStat(_ sender: StatButton) {
		statsButtons.forEach { $0.isActive = false }

		sender.isActive = true

		var stats: Stats

		switch sender.type {
		case .base:
			stats = basetats
		case .min:
			stats = minStats
		case .max:
			stats = maxStats
		}

		statsBars[0].value = stats.hp
		statsBars[1].value = stats.attack
		statsBars[2].value = stats.defense
		statsBars[3].value = stats.speed
		statsBars[4].value = stats.specialAttack
		statsBars[5].value = stats.specialDefense

		UIView.animate(withDuration: 0.4) { [weak self] in
			self?.statsBars[0].progress = CGFloat(stats.hp) / CGFloat(stats.biggestStat)
			self?.statsBars[1].progress = CGFloat(stats.attack) / CGFloat(stats.biggestStat)
			self?.statsBars[2].progress = CGFloat(stats.defense) / CGFloat(stats.biggestStat)
			self?.statsBars[3].progress = CGFloat(stats.speed) / CGFloat(stats.biggestStat)
			self?.statsBars[4].progress = CGFloat(stats.specialAttack) / CGFloat(stats.biggestStat)
			self?.statsBars[5].progress = CGFloat(stats.specialDefense) / CGFloat(stats.biggestStat)
		}
	}
}
