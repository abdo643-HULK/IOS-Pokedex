//
//  PokedexPresenter.swift
//  Pokedex
//
//  Created by Abdo on 14.06.21.
//

import UIKit
import Apollo
import Foundation

typealias SimplePokemon = GenerationQuery.Data.Pokemon

final class PokemonListPresenter {
	public private(set) var pokemons = [[Pokemon]](repeating: [], count: PokeGenerations.allCases.count)
	public let imageLoader = ImageLoader()

	@available(iOS 15.0, *)
	public func loadPokemon(generation: PokeGenerations) async {
		let result = await load(generation: generation)

		switch result {
		case let .success(graphQLResult):
			if let pokemons = graphQLResult.data?.pokemon {
				self.pokemons[generation.rawValue] = pokemons.map {
					Pokemon(id: UInt16($0.id), name: $0.name.capitalizingFirstLetter())
				}
			}
			if let errors = graphQLResult.errors {
				let message = errors
					.map { $0.localizedDescription }
					.joined(separator: "\n")
				print("GraphQL Error(s) \(message)")
			}
		case let .failure(error):
			print("Network Error \(error.localizedDescription)")
		}
	}

	@available(iOS 15.0, *)
	private func load(generation: PokeGenerations) async -> Result<GraphQLResult<GenerationQuery.Data>, Error> {
		await withUnsafeContinuation { c in
			Network.shared.apollo.fetch(query: GenerationQuery(generation: generation.name)) { result in
				c.resume(returning: result)
			}
		}
	}

	public func loadImage(url: URL) async -> UIImage? {
		return await imageLoader.load(url: url)
	}

	public func loadPokemon(generation: PokeGenerations, complete: @escaping () -> Void) {
		Network.shared.apollo.fetch(query: GenerationQuery(generation: generation.name)) { [weak self] result in
			defer {
				complete()
			}

			guard let self = self else {
				return
			}

			switch result {
			case let .success(graphQLResult):
				if let pokemons = graphQLResult.data?.pokemon {
					self.pokemons[generation.rawValue] = pokemons.map {
						Pokemon(id: UInt16($0.id), name: $0.name.capitalizingFirstLetter())
					}
				}
				if let errors = graphQLResult.errors {
					let message = errors
						.map { $0.localizedDescription }
						.joined(separator: "\n")
					print("GraphQL Error(s) \(message)")
				}
			case let .failure(error):
				print("Network Error \(error.localizedDescription)")
			}
		}
	}
}
