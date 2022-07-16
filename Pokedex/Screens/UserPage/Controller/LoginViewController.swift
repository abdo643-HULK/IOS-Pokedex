//
//  LoginViewController.swift
//  Pokedex
//
//  Created by Abdo on 04.07.21.
//

import UIKit
import Firebase

// For Sign in with Google
import GoogleSignIn

// For Sign in with Apple
import CryptoKit
import AuthenticationServices

class LoginViewController: UIViewController {
	// For Sign in with Apple
	private var currentNonce: String?

	private let presenter = LoginViewPresenter()

	private var loginView: LoginView {
		return view as! LoginView
	}

	override func loadView() {
		self.view = LoginView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureDelegatesAndHandlers()
	}

	private func configureDelegatesAndHandlers() {
		loginView.emailField.delegate = self
		loginView.passwordField.delegate = self
		loginView.googleSignInBtn.addTarget(self, action: #selector(performGoogleSignInFlow), for: .touchUpInside)
		loginView.loginBtn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
	}

	@objc
	private func performGoogleSignInFlow() {
		guard let clientID = FirebaseApp.app()?.options.clientID else { return }
		let config = GIDConfiguration(clientID: clientID)
		GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
			if let error = error {
				print(error)
				return
			}
			
			guard let authentication = user?.authentication, let idToken = authentication.idToken  else {
				return
			}
			
			let credential = GoogleAuthProvider.credential(
				withIDToken: idToken,
				accessToken: authentication.accessToken
			)
			
			Task {
				await self.presenter.signInWithGoogle(credentials: credential)
			}
		}
		
//		// Configure the Google Sign In instance
//		GIDSignIn.sharedInstance.clientID = FirebaseApp.app()!.options.clientID
//		GIDSignIn.sharedInstance().delegate = self
//
//		// Start the sign in flow!
//		GIDSignIn.sharedInstance()?.presentingViewController = self
//		GIDSignIn.sharedInstance().signIn()
	}

	@objc
	private func performAppleSignInFlow() {
		let nonce = randomNonceString()
		currentNonce = nonce
		let appleIDProvider = ASAuthorizationAppleIDProvider()
		let request = appleIDProvider.createRequest()
		request.requestedScopes = [.fullName, .email]
		request.nonce = sha256(nonce)

		let authorizationController = ASAuthorizationController(authorizationRequests: [request])
		authorizationController.delegate = self
		authorizationController.presentationContextProvider = self
		authorizationController.performRequests()
	}

	@objc
	private func signIn() {
		guard let email = loginView.emailField.text else { return }
		guard let password = loginView.passwordField.text else { return }

		if !presenter.isValidEmail(email), !presenter.isValidPassword(password) {
			return
		}

		Task {
//			displayActivityIndicatorView()
			await presenter.signIn(email: email, password: password)
//			hideActivityIndicatorView()
		}
	}
}

extension LoginViewController: UITextFieldDelegate {
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if loginView.emailField.isFirstResponder, loginView.passwordField.text!.isEmpty {
			loginView.passwordField.becomeFirstResponder()
		} else {
			textField.resignFirstResponder()
		}
		return true
	}
}

//extension LoginViewController: GIDSignInCallback {
//	public func sign(_: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//		if let error = error {
//			if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//				print("The user has not signed in before or they have since signed out.")
//			} else {
//				print("\(error.localizedDescription)")
//			}
//			return
//		}
//
//		guard let authentication = user.authentication else { return }
//		let credential = GoogleAuthProvider.credential(
//			withIDToken: authentication.idToken,
//			accessToken: authentication.accessToken
//		)
//		async {
//			await self.presenter.signInWithGoogle(credentials: credential)
//		}
//	}
//}

extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
	// MARK: ASAuthorizationControllerDelegate

	public func authorizationController(
		controller _: ASAuthorizationController,
		didCompleteWithAuthorization authorization: ASAuthorization
	) {
		Task { [weak self] in
			do {
				guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
				else {
					print("Unable to retrieve AppleIDCredential")
					return
				}
				try await presenter.signInWithApple(credentials: appleIDCredential)
				// At this point, our user is signed in
				// so we advance to the User View Controller

			} catch {
				// Error. If error.code == .MissingOrInvalidNonce, make sure
				// you're sending the SHA256-hashed nonce as a hex string with
				// your request to Apple.
				self?.displayError(error)
			}
		}
	}
	
	public func displayError(_ error: Error) {
		
	}

	public func authorizationController(controller _: ASAuthorizationController, didCompleteWithError error: Error) {
		// Ensure that you have:
		//  - enabled `Sign in with Apple` on the Firebase console
		//  - added the `Sign in with Apple` capability for this project
		print("Sign in with Apple errored: \(error)")
	}

	// MARK: ASAuthorizationControllerPresentationContextProviding

	public func presentationAnchor(for _: ASAuthorizationController) -> ASPresentationAnchor {
		return view.window!
	}

	// MARK: Aditional `Sign in with Apple` Helpers

	// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
	private func randomNonceString(length: Int = 32) -> String {
		precondition(length > 0)
		let charset: [Character] =
			Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
		var result = ""
		var remainingLength = length

		while remainingLength > 0 {
			let randoms: [UInt8] = (0 ..< 16).map { _ in
				var random: UInt8 = 0
				let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
				if errorCode != errSecSuccess {
					fatalError(
						"Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
					)
				}
				return random
			}

			randoms.forEach { random in
				if remainingLength == 0 {
					return
				}

				if random < charset.count {
					result.append(charset[Int(random)])
					remainingLength -= 1
				}
			}
		}

		return result
	}

	private func sha256(_ input: String) -> String {
		let inputData = Data(input.utf8)
		let hashedData = SHA256.hash(data: inputData)
		let hashString = hashedData.compactMap {
			String(format: "%02x", $0)
		}.joined()

		return hashString
	}
}
