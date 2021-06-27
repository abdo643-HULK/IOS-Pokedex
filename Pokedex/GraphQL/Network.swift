//
//  Network.swift
//  Pokedex
//
//  Created by Abdo on 17.06.21.
//

import Foundation
import Apollo


class Network {
  static let shared = Network()
	
  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://beta.pokeapi.co/graphql/v1beta")!)
}
