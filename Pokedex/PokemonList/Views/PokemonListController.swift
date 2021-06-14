//
//  ViewController.swift
//  Pokedex
//
//  Created by Abdo on 13.06.21.
//

import UIKit

class PokemonListController: UICollectionViewController {
    // MARK: - Properties

    private let reuseIdentifier = "PokeCell"
    private var searches: [String] = []
    public var presenter: PokemonListPresenter!

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.pokemons.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokemonCell
        
        cell.pokemon = presenter.pokemons[indexPath.row]

        return cell
    }
}
