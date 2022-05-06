//
//  LoginView.swift
//  Pokedex
//
//  Created by Abdo on 03.07.21.
//

import UIKit
import Foundation

private let cornerRadius: CGFloat = 15

class LoginView: UIView {
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

	public func setup() {
		self.addSubview(emailField)
		self.addSubview(passwordField)
		self.addSubview(loginBtn)

		setupConstraints()
	}

	private func setupConstraints() {
		let safeArea = self.safeAreaLayoutGuide

		let btnHeight: CGFloat = 50
		let btnWidth: CGFloat = 200

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
			loginBtn.heightAnchor.constraint(equalToConstant: btnHeight),
			loginBtn.widthAnchor.constraint(equalToConstant: btnWidth),

			googleSignInBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20),
			googleSignInBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
		])
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
}
