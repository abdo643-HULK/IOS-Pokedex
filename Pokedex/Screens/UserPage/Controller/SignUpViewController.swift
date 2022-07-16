//
//  SignUpViewController.swift
//  Pokedex
//
//  Created by Abdo on 04.07.21.
//

import UIKit
import Foundation

class SignUpViewController: UIViewController {
	private let presenter = SignUpViewPresenter()

	private var signUpView: SignUpView {
		return view as! SignUpView
	}

	override func loadView() {
		view = signUpView
	}

	@objc
	private func signUp() {
		guard let email = signUpView.emailField.text else { return }
		guard let password = signUpView.passwordField.text else { return }

		if !presenter.isValidEmail(email), !presenter.isValidPassword(password) {
			return
		}

		Task {
//			displayActivityIndicatorView()
			await presenter.createUser(email: email, password: password)
//			hideActivityIndicatorView()
		}
	}
}
