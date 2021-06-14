//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Abdo on 14.06.21.
//

import Foundation
import UIKit

class PokemonCell: UICollectionViewCell {
    // MARK: - Private Properties
    private var pokeImage: UIImageView {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.borderColor = UIColor.black.cgColor
        return img
    }
    // MARK: - Public Properties
    public var pokemon: Pokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            pokemon.name
        }
    }
}
