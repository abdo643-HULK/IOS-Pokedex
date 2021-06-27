//
//  ViewController.swift
//  Pokedex
//
//  Created by Abdo on 13.06.21.
//

import UIKit

let POKEMONS_PER_GEN: [Int] = [151, 100, 135, 107, 156, 72, 88, 89]

class PokemonListController: UICollectionViewController {
	// MARK: - Immutable Private Properties

	private let headerId = "Header"
	private let reuseIdentifier = "PokeCell"
	private let sectionInsets = UIEdgeInsets(top: 17, left: 15, bottom: 25.0, right: 15)
	private let presenter = PokemonListPresenter()

	// MARK: - Mutable Private Properties

	private var fetchedGen = [Bool](repeating: false, count: PokeGenerations.allCases.count)
	private var pokemonsPerRow: CGFloat = 3
	private var width: CGFloat = 0

	override func viewDidLoad() {
		super.viewDidLoad()
//		collectionView.prefetchDataSource = dataSource
		displayActivityIndicatorView()

		async {
			await presenter.loadPokemon(generation: .gen1)
			fetchedGen[0] = true
			collectionView.reloadData()
			hideActivityIndicatorView()
		}

		setupConstraints()
		layoutTrait(traitCollection: UIScreen.main.traitCollection)

		collectionView.register(
			PokemonListHeader.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: headerId
		)
		collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: reuseIdentifier)
	}

	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		layoutTrait(traitCollection: traitCollection)
	}

	// MARK: - UICollectionViewDataSource

	override func numberOfSections(in _: UICollectionView) -> Int {
		return PokeGenerations.allCases.count
	}

	override func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.pokemons[section].count
	}

	override func collectionView(
		_ collectionView: UICollectionView,
		viewForSupplementaryElementOfKind kind: String,
		at indexPath: IndexPath
	) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(
			ofKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: headerId, for: indexPath) as! PokemonListHeader

		header.generation = "Generation \(indexPath.section + 1)"
		
		return header
	}

//	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//		// Begin asynchronously fetching data for the requested index paths.
//		for indexPath in indexPaths {
//			print(indexPath.section)
//		}
//	}

	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let max = PokeGenerations.allCases.count - 1
		let con = indexPath.section + 1 > max ? max : indexPath.section + 1

		if Double(indexPath.row) / Double(POKEMONS_PER_GEN[indexPath.section]) > 0.9, fetchedGen[con] == false {
			fetchedGen[con] = true
			async {
				await presenter.loadPokemon(generation: PokeGenerations(rawValue: indexPath.section + 1) ?? .gen1)
				collectionView.reloadData()
			}
		}

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCell

		cell.pokemon = presenter.pokemons[indexPath.section][indexPath.row]
//		async {
//			cell.image = await presenter.loadImage(url: presenter.pokemons[indexPath.section][indexPath.row].imageURL)
//		}
		return cell
	}

	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let pokemon = presenter.pokemons[indexPath.section][indexPath.row]
		let pokeDetails = PokemonDetailsController()
		pokeDetails.id = UInt16(pokemon.id)
		pokeDetails.name = pokemon.name
		pokeDetails.imageURL = pokemon.imageURL
		
		navigationController?.pushViewController(pokeDetails, animated: true)
	}
}

extension PokemonListController: UICollectionViewDelegateFlowLayout {
	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		let paddingSpace = sectionInsets.left * (pokemonsPerRow + 1)
		let availableWidth = width - paddingSpace

		let widthPerItem = availableWidth / pokemonsPerRow

		return CGSize(width: widthPerItem, height: widthPerItem)
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		insetForSectionAt section: Int
	) -> UIEdgeInsets {
		return sectionInsets
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return sectionInsets.left
	}

	func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		referenceSizeForHeaderInSection section: Int
	) -> CGSize {
		return CGSize(width: view.frame.width, height: 60)
	}
}

extension PokemonListController {
	private func layoutTrait(traitCollection: UITraitCollection) {
		if traitCollection.horizontalSizeClass == .compact, traitCollection.verticalSizeClass == .regular {
			width = collectionView.frame.width
			pokemonsPerRow = 2
		} else {
			let window = UIApplication.shared.windows.first { $0.isKeyWindow } ?? UIApplication.shared.windows[0]
			let leftPadding = window.safeAreaInsets.left
			let rightPadding = window.safeAreaInsets.right
			width = collectionView.frame.width - leftPadding - rightPadding
			pokemonsPerRow = 3
		}
	}

	private func setupConstraints() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
	}
}
