//
//  Progressbar.swift
//  Pokedex
//
//  Created by Abdo on 25.06.21.
//

import Foundation
import UIKit

final class StatsProgressBar: UIView {
//	private let progressLayer = CALayer()
	private let backgroundMask = CAShapeLayer()

	private let statsNumberLabels: PaddingLabel = {
		let lbl = PaddingLabel()
		lbl.text = "0"
		lbl.textAlignment = .right
		lbl.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 20, weight: .bold))
		lbl.clipsToBounds = true
		return lbl
	}()

	public var color: UIColor = .gray { // UIColor(hex: "#929292")
		didSet {
//			progressLayer.backgroundColor = color.cgColor
			statsNumberLabels.backgroundColor = color
		}
	}

	public var progress: CGFloat = 0.5 {
		didSet {
//			progressLayer.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width * progress, height: bounds.height))
			statsNumberLabels.frame = CGRect(origin: .zero, size: CGSize(width: bounds.width * progress, height: bounds.height))
		}
	}

	public var value: UInt16 = 0 {
		didSet {
			statsNumberLabels.text = "\(value)"
		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
//		self.layer.addSublayer(progressLayer)
		self.addSubview(statsNumberLabels)
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		let cornerRadius = bounds.height * 0.25
		backgroundMask.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
		layer.mask = backgroundMask

		let progressRect = CGRect(origin: .zero, size: CGSize(width: bounds.width * progress, height: bounds.height))
		statsNumberLabels.frame = progressRect
		statsNumberLabels.layer.cornerRadius = cornerRadius

//		progressLayer.frame = progressRect
//		progressLayer.cornerRadius = cornerRadius

//		progressLayer.backgroundColor = color.cgColor
	}

	@available(*, unavailable)
	required init?(coder _: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private final class PaddingLabel: UILabel {
	let padding = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: padding))
	}

	override var intrinsicContentSize: CGSize {
		let superContentSize = super.intrinsicContentSize
		let width = superContentSize.width + padding.left + padding.right
		let heigth = superContentSize.height + padding.top + padding.bottom
		return CGSize(width: width, height: heigth)
	}
}
