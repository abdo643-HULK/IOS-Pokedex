//
//  LoginView.swift
//  Pokedex
//
//  Created by Abdo on 03.07.21.
//

import UIKit
import Foundation

private let cornerRadius: CGFloat = 10

final class LoginView: UIView {
	public let emailField: UITextField = {
		let field = UITextField()
		field.translatesAutoresizingMaskIntoConstraints = false
		field.placeholder = "Email"
		field.layer.masksToBounds = true
		field.layer.borderWidth = 1
		field.layer.cornerRadius = cornerRadius
		field.keyboardType = .emailAddress
		field.textContentType = .emailAddress
		field.returnKeyType = .continue
		field.backgroundColor = .blue
		field.leftView = UIImageView(image: UIImage(systemName: "email"))
		field.leftViewMode = .always

		return field
	}()

	public let passwordField: UITextField = {
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
		field.textContentType = .password

		return field
	}()

	public let loginBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Log In", for: .normal)
		btn.layer.cornerRadius = cornerRadius
		btn.layer.masksToBounds = true
		btn.backgroundColor = UIColor(named: "LoginBtnColors")

		return btn
	}()

	public let googleSignInBtn: GoogleSignInButton = {
		let btn = GoogleSignInButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		return btn
	}()

	convenience init() {
		self.init(frame: .zero)
		setup()
	}

	public func setup() {
		self.addSubview(loginBtn)
		self.addSubview(emailField)
		self.addSubview(passwordField)
		self.addSubview(googleSignInBtn)
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
			googleSignInBtn.heightAnchor.constraint(equalToConstant: btnHeight + 10),
			googleSignInBtn.widthAnchor.constraint(equalToConstant: btnWidth + 100),
		])
	}

	private func textField(placeholder: String, symbolName: String) -> UITextField {
		let textfield = UITextField()
		textfield.backgroundColor = .secondarySystemBackground
		textfield.layer.cornerRadius = cornerRadius
		textfield.placeholder = placeholder
		textfield.tintColor = .systemOrange
		let symbol = UIImage(systemName: symbolName)
		textfield.leftView = UIImageView(image: symbol)
		return textfield
	}
}
