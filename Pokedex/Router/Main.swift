//
//  Router.swift
//  Pokedex
//
//  Created by Abdo on 19.06.21.
//

import Foundation
import UIKit

class TabBar: UITabBarController {
	//		mainVC.presenter = PokemonListPresenter()
	let layout: UICollectionViewFlowLayout = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		return layout
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		UINavigationBar.appearance().backgroundColor = .bgColor
		UINavigationBar.appearance().barTintColor = .bgColor
		UINavigationBar.appearance().tintColor = .label
		
		UITabBar.appearance().backgroundColor = .bgColor
		UITabBar.appearance().barTintColor = .bgColor
		view.backgroundColor = .bgColor
		tabBar.tintColor = .label
		setupVCs()
	}

	func setupVCs() {
		let homeController = PokemonListController(collectionViewLayout: layout)
		let userPageController = UserPageController()

		viewControllers = [
			createNavController(for: homeController, title: "Pokemon", image: UIImage(named: "pokeball-icon")!),
			createNavController(for: userPageController, title: "Profile", image: UIImage(systemName: "person")!)
		]
	}

	private func createNavController(for rootViewController: UIViewController, title: String? = nil, image: UIImage? = nil) -> UIViewController {
		let navController = UINavigationController(rootViewController: rootViewController)
		navController.navigationBar.prefersLargeTitles = true
		if let title = title {
			navController.tabBarItem.title = title
			rootViewController.navigationItem.title = title
		}
		if let image = image {
			navController.tabBarItem.image = image
		}
		return navController
	}
}
