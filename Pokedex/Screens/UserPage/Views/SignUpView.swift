//
//  SignUpPage.swift
//  Pokedex
//
//  Created by Abdo on 26.06.21.
//

import UIKit
import Foundation

private let cornerRadius: CGFloat = 15

class SignUpView: UIView {
	public let emailField: UITextField = {
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

		return field
	}()

	public let signUpBtn: UIButton = {
		let btn = UIButton()
		btn.translatesAutoresizingMaskIntoConstraints = false
		btn.setTitle("Sign Up", for: .normal)
		btn.layer.cornerRadius = cornerRadius
		btn.layer.masksToBounds = true
		btn.backgroundColor = UIColor(named: "LoginBtnColors")

		return btn
	}()
}
