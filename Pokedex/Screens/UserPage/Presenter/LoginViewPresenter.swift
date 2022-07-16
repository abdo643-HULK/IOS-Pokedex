//
//  LoginViewPresenter.swift
//  Pokedex
//
//  Created by Abdo on 04.07.21.
//

import Foundation
import FirebaseAuth

// For Sign in with Apple
import CryptoKit
import AuthenticationServices

extension AuthErrorCode: Error {}

struct LoginViewPresenter {
	private var currentNonce: String?

	public func signIn(email: String, password: String) async {
		do {
			_ = try await Auth.auth().signIn(withEmail: email, password: password)
			print("User signs in successfully")
		} catch {
			let error = error as NSError
			switch AuthErrorCode(rawValue: error.code) {
			case .operationNotAllowed:
				// Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
				print("Operation not allowed")
			case .userDisabled:
				// Error: The user account has been disabled by an administrator.
				print("User Disabled")
			case .wrongPassword:
				// Error: The password is invalid or the user does not have a password.
				print("Wrong Password")
			case .invalidEmail:
				// Error: Indicates the email address is malformed.
				print("Invalid Email")
			default:
				print("Error: \(error.localizedDescription)")
			}
		}
	}

	public func signInWithGoogle(credentials: AuthCredential) async {
		do {
			_ = try await Auth.auth().signIn(with: credentials)
		} catch {
			let authError = error as NSError
			if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
			} else {
				print(error.localizedDescription)
				return
			}
			return
		}
	}

	public func signInWithApple(credentials: ASAuthorizationAppleIDCredential) async throws {
		guard let nonce = currentNonce else {
			fatalError("Invalid state: A login callback was received, but no login request was sent.")
		}
		guard let appleIDToken = credentials.identityToken else {
			print("Unable to fetch identity token")
			return
		}
		guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
			print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
			return
		}

		let credential = OAuthProvider.credential(
			withProviderID: "apple.com",
			idToken: idTokenString,
			rawNonce: nonce
		)

		do {
			let authResult = try await Auth.auth().signIn(with: credential)
		} catch {
			let error = error as NSError
			switch AuthErrorCode(rawValue: error.code) {
			case .invalidCredential:
				// Error: Indicates the supplied credential is invalid. This could happen if it has expired or it is malformed.
				print("Operation not allowed")
			case .invalidEmail:
				// Error: Indicates the email address is malformed, if credential is of the type EmailPasswordAuthCredential.
				print("User Disabled")
			case .operationNotAllowed:
				// Error: Indicates that accounts with the identity provider represented by the credential are not enabled. Enable them in the Auth section of the Firebase console
				print("Wrong Password")
			case .emailAlreadyInUse:
				/* Error: Indicates the email asserted by the credential (e.g. the email in a Facebook access token) is already in use by an existing account, that cannot be authenticated with this sign-in method. Call fetchProvidersForEmail for this user’s email  and then prompt them to sign in with any of the sign-in providers returned. This error will only be thrown if the "One account per email address" setting is enabled in the Firebase console, under Authentication settings.
				 */
				print("Invalid Email")
			case .userDisabled:
				// Error: Indicates the user's account is disabled.
				print("Invalid Email")
			case .wrongPassword:
				// Error: Indicates the user attempted sign in with a wrong password, if credential is of the type EmailPasswordAuthCredential.
				print("Invalid Email")
			default:
				print("Error: \(error.localizedDescription)")
			}
			throw AuthErrorCode(rawValue: error.code) ?? AuthErrorCode.internalError
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
