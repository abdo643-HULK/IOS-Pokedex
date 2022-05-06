//
//  UIView.swift
//  Pokedex
//
//  Created by Abdo on 19.06.21.
//

import Foundation
import UIKit

private let activityIndicatorViewTag: Int = 1000
// Public interface
extension UIView {
	func displayActivityIndicatorView() {
		setActivityIndicatorView()
	}

	func hideActivityIndicatorView() {
		removeActivityIndicatorView()
	}
}

extension UIViewController {
	private var overlayContainerView: UIView {
		if let navigationView: UIView = navigationController?.view {
			return navigationView
		}
		return view
	}

	func displayActivityIndicatorView() {
		overlayContainerView.displayActivityIndicatorView()
	}

	func hideActivityIndicatorView() {
		overlayContainerView.hideActivityIndicatorView()
	}
}

// Private interface
extension UIView {
	private var activityIndicatorView: UIActivityIndicatorView {
		let view = UIActivityIndicatorView(style: .large)
		view.translatesAutoresizingMaskIntoConstraints = false
		view.tag = activityIndicatorViewTag
		return view
	}

	private func setActivityIndicatorView() {
		guard !isDisplayingActivityIndicator() else { return }
		let activityIndicatorView: UIActivityIndicatorView = self.activityIndicatorView
		// add subviews
		addSubview(activityIndicatorView)
		// add indicator constraints
		activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
		// animate indicator
		activityIndicatorView.startAnimating()
	}

	private func removeActivityIndicatorView() {
		guard let activityIndicator: UIActivityIndicatorView = getActivityIndicatorView() else {
			return
		}

		UIView.animate(withDuration: 0.2, animations: {
			activityIndicator.stopAnimating()
		}) { _ in
			activityIndicator.removeFromSuperview()
		}
	}

	private func isDisplayingActivityIndicator() -> Bool {
		getActivityIndicatorView() != nil
	}

	private func getActivityIndicatorView() -> UIActivityIndicatorView? {
		viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView
	}
}
