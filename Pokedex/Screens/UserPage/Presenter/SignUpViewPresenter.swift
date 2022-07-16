//
//  SignUpViewPresenter.swift
//  Pokedex
//
//  Created by Abdo on 04.07.21.
//

import Foundation
import FirebaseAuth

struct SignUpViewPresenter {
	public func createUser(email: String, password: String) async {
		do {
			let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
			print("User signs up successfully")
		} catch {
			let error = error as NSError
			switch AuthErrorCode(rawValue: error.code) {
			case .operationNotAllowed:
				// Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
				print("Operation not allowed")
			case .emailAlreadyInUse:
				// Error: The email address is already in use by another account.
				print("Email already in use")
			case .invalidEmail:
				// Error: The email address is badly formatted.
				print("Invalid Email")
			case .weakPassword:
				// Error: The password must be 6 characters long or more.
				print("Weak Password")
			default:
				print("Error: \(error.localizedDescription)")
			}
		}
	}

	public func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}

	public func isValidPassword(_ password: String) -> Bool {
		let minPasswordLength = 6
		return password.count >= minPasswordLength
	}
}
