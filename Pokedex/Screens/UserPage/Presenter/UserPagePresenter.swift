//
//  UserPagePresenter.swift
//  Pokedex
//
//  Created by Abdo on 19.06.21.
//

import Foundation
import FirebaseAuth

class UserPagePresenter {
	public var user: User?

	public func addUserListener() -> (() -> Void) {
		let handle = Auth.auth().addStateDidChangeListener { _, user in
			self.user = user
		}

		return {
			Auth.auth().removeStateDidChangeListener(handle)
		}
	}

	public func signOut() {
		do {
			try Auth.auth().signOut()
		} catch {
			print("Sign out error")
		}
	}
}
