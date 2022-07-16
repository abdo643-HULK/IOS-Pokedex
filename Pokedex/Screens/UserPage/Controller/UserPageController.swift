//
//  UserPageController.swift
//  Pokedex
//
//  Created by Abdo on 19.06.21.
//

import UIKit
import Foundation

class UserPageController: UIViewController {
	private let presenter = UserPagePresenter()

	private let signOutBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Sign Out", for: .normal)
		return btn
	}()

	private let signInBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Sign In", for: .normal)
		btn.setTitleColor(UIColor.offBlack, for: .normal)
		btn.titleLabel?.font = UIFont.systemFont(ofSize: 24)
		btn.layer.cornerRadius = 15
		btn.layer.borderWidth = 1
		btn.addTarget(self, action: #selector(showLoginView), for: .touchUpInside)
		return btn
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		if presenter.user == nil {
			showLoggedOutScreen()
		} else {
			showLoggedInScreen()
		}
	}

	override func viewWillAppear(_: Bool) {
		super.viewWillAppear(true)
	}

	override func viewWillDisappear(_: Bool) {
		super.viewWillDisappear(true)
	}

	private func showLoggedInScreen() {
		view.addSubview(signOutBtn)
	}

	private func showLoggedOutScreen() {
//		view.addSubview(signInBtn)
//		setupConstraints()
		view = LoginView()
	}

	private func setupConstraints() {
		NSLayoutConstraint.activate([
			signInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			signInBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			signInBtn.widthAnchor.constraint(equalToConstant: 270),
			signInBtn.heightAnchor.constraint(equalToConstant: 60),
		])
	}

	@objc
	private func showLoginView() {
		let loginView = LoginViewController()
		let nav = UINavigationController(rootViewController: loginView)
		nav.modalPresentationStyle = .fullScreen
		navigationController?.present(nav, animated: true, completion: nil)
	}

	@objc
	private func signOut() {
		presenter.signOut()
	}
}
