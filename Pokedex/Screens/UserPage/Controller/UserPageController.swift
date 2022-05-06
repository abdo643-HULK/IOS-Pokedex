//
//  UserPageController.swift
//  Pokedex
//
//  Created by Abdo on 19.06.21.
//

import UIKit
import Foundation

private let cornerRadius: CGFloat = 15

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
		return btn
	}()

	override func viewDidLoad() {
		if presenter.user != nil {
			showLoggedInScreen()
		} else {
			showLoggedOutScreen()
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
		view.addSubview(signInBtn)
	}
	
	private func setupConstraints(){
		NSLayoutConstraint.activate([
			signInBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			signInBtn.widthAnchor.constraint(equalToConstant: 270)
		])
	}

	@objc
	private func showLoginView() {
		let loginView = LoginViewController()
		let nav = UINavigationController(rootViewController: loginView)
		nav.modalPresentationStyle = .fullScreen
		nav.present(loginView, animated: true, completion: nil)
	}

	@objc
	private func signOut() {
		presenter.signOut()
	}
}
