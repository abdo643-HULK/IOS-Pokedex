//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created by Abdo on 22.06.21.
//

import Apollo
import Foundation

typealias PokeDetails = PokemonDetailsQuery.Data.Pokemon

final class PokemonDetailsPresenter {
	public private(set) var pokemon: PokemonDetails?

	@available(iOS 15.0, *)
	public func getPokemonDetails(id: Int) async {
		let result = await load(id: id)

		switch result {
			case .success(let graphQLResult): 
				if let pokemon = graphQLResult.data?.pokemon {
					self.pokemon = PokemonDetails(
						id: UInt16(id),
						name: pokemon.name.capitalizingFirstLetter(),
						imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")!,
						height: Float16(pokemon.height ?? 0) / 10,
						weight: Float16(pokemon.weight ?? 0) / 10,
						types: pokemon.typeDetails.map { $0.types?.name ?? "" },
						abilities: pokemon.abilities.map { Ability(slot: UInt8($0.slot), name: $0.ability?.name ?? "") },
						baseStats: Stats(
							hp: UInt16((pokemon.stats.filter { $0.stat?.name == "hp" })[0].base),
							attack: UInt16(pokemon.stats.filter { $0.stat?.name == "attack" }[0].base),
							defense: UInt16(pokemon.stats.filter { $0.stat?.name == "defense" }[0].base),
							speed: UInt16(pokemon.stats.filter { $0.stat?.name == "speed" }[0].base),
							specialAttack: UInt16(pokemon.stats.filter { $0.stat?.name == "special-attack" }[0].base),
							specialDefense: UInt16(pokemon.stats.filter { $0.stat?.name == "special-defense" }[0].base)
						),
						generation: pokemon.species?.generation?.name ?? "",
						isLegendary: pokemon.species?.isLegendary,
						isMythical: pokemon.species?.isMythical,
						captureRate: pokemon.species?.captureRate != nil ? UInt8((pokemon.species?.captureRate)!) : nil,
						isFormSwitchable: pokemon.species?.isFormSwitchable,
						hasGenderDiff: pokemon.species?.hasGenderDiff,
						genderRate: pokemon.species?.genderRate != nil ? GenderRates(rate: Int8((pokemon.species?.genderRate)!)) : nil,
						evoltutions: pokemon.species?.evolutions?.info.map { ev -> Evolution? in
							if ev.evolutionDetails.count > 0 {
								let details = ev.evolutionDetails[0]
								return Evolution(
									name: ev.name,
									previousEvolution: ev.previousEvolution != nil ? UInt16(ev.previousEvolution!) : nil,
									trigger: Evolutiontrigger(rawValue: details.trigger?.name ?? "unknown"),
									minLvl: details.minLvl != nil ? UInt8(details.minLvl!) : nil,
									neededItem: details.neededItem?.name,
									neededTime: details.neededTime,
									neededLocation: details.neededLocation?.name,
									neededHappiness: details.neededHappiness != nil ? UInt16(details.neededHappiness!) : nil,
									neededAffection: details.neededAffection != nil ? UInt16(details.neededAffection!) : nil,
									needsRain: details.needsRain
								)
							}
							else {
								return nil
							}
						} ?? [],
						forms: pokemon.species?.pokeForms.map { form in
							PokemonForm(
								id: UInt16(form.id),
								name: form.name,
								imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(form.id).png")!,
								height: Float16(form.height ?? 0) / 10,
								weight: Float16(form.weight ?? 0) / 10,
								types: form.typeDetails.map { $0.types?.name ?? "" },
								abilities: form.abilities.map { Ability(slot: UInt8($0.slot), name: $0.ability?.name ?? "") },
								baseStats: Stats(
									hp: UInt16((form.stats.filter { $0.stat?.name == "hp" })[0].base),
									attack: UInt16(form.stats.filter { $0.stat?.name == "attack" }[0].base),
									defense: UInt16(form.stats.filter { $0.stat?.name == "defense" }[0].base),
									speed: UInt16(form.stats.filter { $0.stat?.name == "speed" }[0].base),
									specialAttack: UInt16(form.stats.filter { $0.stat?.name == "special-attack" }[0].base),
									specialDefense: UInt16(form.stats.filter { $0.stat?.name == "special-defense" }[0].base)
								),
								formName: form.formDetails[0].formName
							)
						} ?? []
					)
				}
				if let errors = graphQLResult.errors {
					let message = errors
						.map { $0.localizedDescription }
						.joined(separator: "\n")
					print("GraphQL Error(s) \(message)")
				}
			case .failure(let error):
				print("Network Error \(error.localizedDescription)")
		}
	}

	@available(iOS 15.0, *)
	private func load(id: Int) async -> Result<GraphQLResult<PokemonDetailsQuery.Data>, Error> {
		await withUnsafeContinuation { c in
			Network.shared.apollo.fetch(query: PokemonDetailsQuery(id: id)) { result in
				c.resume(returning: result)
			}
		}
	}
}

// struct PokemonDetailsPresenter {
// public private(set) var pokemon: PokemonDetails?
//
// @available(iOS 15.0, *)
// public func getPokemonDetails(id: Int) async {
//	let result = await load(id: id)
//
//	switch result {
//		case .success(let graphQLResult):
//			if let pokemon = graphQLResult.data?.pokemon {
//				self.pokemon = PokemonDetails(
//					id: UInt16(id),
//					name: pokemon.name,
//					height: Float16(pokemon.height ?? 0),
//					weight: Float16(pokemon.weight ?? 0),
//					types: pokemon.typeDetails.map { $0.types?.name ?? "" },
//					abilities: pokemon.abilities.map { Ability(slot: UInt8($0.slot), name: $0.ability?.name ?? "") },
//					baseStats: Stats(
//						hp: UInt16((pokemon.stats.filter { $0.stat?.name == "hp" })[0].base),
//						attack: UInt16(pokemon.stats.filter { $0.stat?.name == "attack" }[0].base),
//						defense: UInt16(pokemon.stats.filter { $0.stat?.name == "defense" }[0].base),
//						speed: UInt16(pokemon.stats.filter { $0.stat?.name == "speed" }[0].base),
//						specialAttack: UInt16(pokemon.stats.filter { $0.stat?.name == "specialAttack" }[0].base),
//						specialDefense: UInt16(pokemon.stats.filter { $0.stat?.name == "specialDefense" }[0].base)
//					),
//					generation: pokemon.species?.generation?.name ?? "",
//					isLegendary: pokemon.species?.isLegendary,
//					isMythical: pokemon.species?.isMythical,
//					captureRate: pokemon.species?.captureRate != nil ? UInt8((pokemon.species?.captureRate)!) : nil,
//					isFormSwitchable: pokemon.species?.isFormSwitchable,
//					hasGenderDiff: pokemon.species?.hasGenderDiff,
//					genderRate: pokemon.species?.genderRate != nil ? GenderRates(rate: Int8((pokemon.species?.genderRate)!)) : nil,
//					evoltutions: pokemon.species?.evolutions?.info.map { ev in
//						let details = ev.evolutionDetails[0]
//						return Evolution(
//							name: ev.name,
//							previousEvolution: ev.previousEvolution != nil ? UInt16(ev.previousEvolution!) : nil,
//							trigger: EvolutionTrigger(rawValue: details.trigger?.name ?? "unknown"),
//							minLvl: details.minLvl != nil ? UInt8(details.minLvl!) : nil,
//							neededItem: details.neededItem?.name,
//							neededTime: details.neededTime,
//							neededLocation: details.neededLocation?.name,
//							neededHappiness: details.neededHappiness != nil ? UInt16(details.neededHappiness!) : nil,
//							neededAffection: details.neededAffection != nil ? UInt16(details.neededAffection!) : nil,
//							needsRain: details.needsRain
//						)
//					} ?? [],
//					forms: pokemon.species?.pokeForms.map { form in
//						PokemonForm(
//							id: UInt16(form.id),
//							name: form.name,
//							height: Float16(form.height ?? 0) / 100,
//							weight: Float16(form.weight ?? 0) / 100,
//							types: form.typeDetails.map { $0.types?.name ?? "" },
//							abilities: form.abilities.map { Ability(slot: UInt8($0.slot), name: $0.ability?.name ?? "") },
//							baseStats: Stats(
//								hp: UInt16((form.stats.filter { $0.stat?.name == "hp" })[0].base),
//								attack: UInt16(form.stats.filter { $0.stat?.name == "attack" }[0].base),
//								defense: UInt16(form.stats.filter { $0.stat?.name == "defense" }[0].base),
//								speed: UInt16(form.stats.filter { $0.stat?.name == "speed" }[0].base),
//								specialAttack: UInt16(form.stats.filter { $0.stat?.name == "specialAttack" }[0].base),
//								specialDefense: UInt16(form.stats.filter { $0.stat?.name == "specialDefense" }[0].base)
//							),
//							formName: form.formDetails[0].formName
//						)
//					} ?? []
//				)
//			}
//			if let errors = graphQLResult.errors {
//				let message = errors
//					.map { $0.localizedDescription }
//					.joined(separator: "\n")
//				print("GraphQL Error(s) \(message)")
//			}
//		case .failure(let error):
//			print("Network Error \(error.localizedDescription)")
//	}
// }
//
// @available(iOS 15.0, *)
// private func load(id: Int) async -> Result<GraphQLResult<PokemonDetailsQuery.Data>, Error> {
//	await withUnsafeContinuation { c in
//		Network.shared.apollo.fetch(query: PokemonDetailsQuery(id: id)) { result in
//			c.resume(returning: result)
//		}
//	}
// }
// }
