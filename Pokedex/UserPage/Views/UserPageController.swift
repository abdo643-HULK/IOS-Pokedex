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

	private let emailField: UITextField = {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		field.placeholder = "Email"
		field.layer.masksToBounds = true
		field.layer.borderWidth = 1
		field.layer.cornerRadius = cornerRadius
		field.keyboardType = .emailAddress
		field.returnKeyType = .done
		field.backgroundColor = .blue

		return field
	}()

	private let passwordField: UITextField = {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		field.isSecureTextEntry = true
		field.placeholder = "Password"
		field.layer.masksToBounds = true
		field.layer.borderWidth = 1
		field.layer.cornerRadius = cornerRadius
		field.keyboardType = .default
		field.returnKeyType = .done
		field.backgroundColor = .blue

		return field
	}()

	private let loginBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Log In", for: .normal)
		btn.layer.cornerRadius = cornerRadius
		btn.layer.masksToBounds = true
		btn.backgroundColor = UIColor(named: "LoginBtnColors")
		btn.addTarget(self, action: #selector(signIn), for: .touchUpInside)

		return btn
	}()

	private let signUpBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Sign Up", for: .normal)
		btn.layer.cornerRadius = cornerRadius
		btn.layer.masksToBounds = true
		btn.backgroundColor = UIColor(named: "LoginBtnColors")

		return btn
	}()

	private let signOutBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Sign Out", for: .normal)
		return btn
	}()

	override func viewDidLoad() {
		if presenter.user != nil {
			showLoggedInScreen()
		} else {
			showLoggedOutScreen()
		}
	}

	private func showLoggedInScreen() {
		view.addSubview(signOutBtn)
	}

	private func showLoggedOutScreen() {
		view.addSubview(emailField)
		view.addSubview(passwordField)
		view.addSubview(loginBtn)
		view.addSubview(signUpBtn)

		let safeArea = view.safeAreaLayoutGuide

		NSLayoutConstraint.activate([
			emailField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
			emailField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
			emailField.heightAnchor.constraint(equalToConstant: 50),
			emailField.widthAnchor.constraint(greaterThanOrEqualToConstant: 350),

			passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 15),
			passwordField.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
			passwordField.heightAnchor.constraint(equalToConstant: 50),
			passwordField.widthAnchor.constraint(greaterThanOrEqualToConstant: 350),

			loginBtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
			loginBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
			loginBtn.heightAnchor.constraint(equalToConstant: 50),
			loginBtn.widthAnchor.constraint(equalToConstant: 200),

			signUpBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
			signUpBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
			signUpBtn.heightAnchor.constraint(equalToConstant: 50),
			signUpBtn.widthAnchor.constraint(equalToConstant: 200),
		])
	}

	@objc
	private func signUp() {
		guard let email = emailField.text else { return }
		guard let password = passwordField.text else { return }

		if !presenter.isValidEmail(email), !presenter.isValidPassword(password) {
			return
		}

		async {
			displayActivityIndicatorView()
			await presenter.createUser(email: email, password: password)
			hideActivityIndicatorView()
		}
	}

	@objc
	private func signIn() {
		guard let email = emailField.text else { return }
		guard let password = passwordField.text else { return }

		if !presenter.isValidEmail(email), !presenter.isValidPassword(password) {
			return
		}

		async {
			displayActivityIndicatorView()
			await presenter.signIn(email: email, password: password)
			hideActivityIndicatorView()
		}
	}

	@objc
	private func signOut() {
		presenter.signOut()
	}
}
