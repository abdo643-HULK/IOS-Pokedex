// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GenerationQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query generation($generation: String = "generation-i") {
      pokemon: pokemon_v2_pokemonspecies(
        where: {pokemon_v2_generation: {name: {_eq: $generation}}}
        order_by: {id: asc}
      ) {
        __typename
        id
        name
      }
    }
    """

  public let operationName: String = "generation"

  public var generation: String?

  public init(generation: String? = nil) {
    self.generation = generation
  }

  public var variables: GraphQLMap? {
    return ["generation": generation]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemon_v2_pokemonspecies", alias: "pokemon", arguments: ["where": ["pokemon_v2_generation": ["name": ["_eq": GraphQLVariable("generation")]]], "order_by": ["id": "asc"]], type: .nonNull(.list(.nonNull(.object(Pokemon.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pokemon: [Pokemon]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "pokemon": pokemon.map { (value: Pokemon) -> ResultMap in value.resultMap }])
    }

    /// An array relationship
    public var pokemon: [Pokemon] {
      get {
        return (resultMap["pokemon"] as! [ResultMap]).map { (value: ResultMap) -> Pokemon in Pokemon(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Pokemon) -> ResultMap in value.resultMap }, forKey: "pokemon")
      }
    }

    public struct Pokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["pokemon_v2_pokemonspecies"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String) {
        self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonspecies", "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

public final class PartialGenerationQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query partialGeneration($generation: String = "generation-i", $offset: Int = 0) {
      pokemon: pokemon_v2_pokemonspecies(
        offset: $offset
        limit: 40
        where: {pokemon_v2_generation: {name: {_eq: $generation}}}
        order_by: {id: asc}
      ) {
        __typename
        id
        name
      }
    }
    """

  public let operationName: String = "partialGeneration"

  public var generation: String?
  public var offset: Int?

  public init(generation: String? = nil, offset: Int? = nil) {
    self.generation = generation
    self.offset = offset
  }

  public var variables: GraphQLMap? {
    return ["generation": generation, "offset": offset]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemon_v2_pokemonspecies", alias: "pokemon", arguments: ["offset": GraphQLVariable("offset"), "limit": 40, "where": ["pokemon_v2_generation": ["name": ["_eq": GraphQLVariable("generation")]]], "order_by": ["id": "asc"]], type: .nonNull(.list(.nonNull(.object(Pokemon.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pokemon: [Pokemon]) {
      self.init(unsafeResultMap: ["__typename": "query_root", "pokemon": pokemon.map { (value: Pokemon) -> ResultMap in value.resultMap }])
    }

    /// An array relationship
    public var pokemon: [Pokemon] {
      get {
        return (resultMap["pokemon"] as! [ResultMap]).map { (value: ResultMap) -> Pokemon in Pokemon(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Pokemon) -> ResultMap in value.resultMap }, forKey: "pokemon")
      }
    }

    public struct Pokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["pokemon_v2_pokemonspecies"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: Int, name: String) {
        self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonspecies", "id": id, "name": name])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: Int {
        get {
          return resultMap["id"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }
    }
  }
}

public final class PokemonDetailsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query pokemonDetails($id: Int!) {
      pokemon: pokemon_v2_pokemon_by_pk(id: $id) {
        __typename
        name
        height
        weight
        typeDetails: pokemon_v2_pokemontypes {
          __typename
          types: pokemon_v2_type {
            __typename
            name
          }
        }
        abilities: pokemon_v2_pokemonabilities(order_by: {slot: asc_nulls_first}) {
          __typename
          slot
          ability: pokemon_v2_ability {
            __typename
            name
          }
        }
        stats: pokemon_v2_pokemonstats {
          __typename
          stat: pokemon_v2_stat {
            __typename
            name
          }
          base: base_stat
        }
        species: pokemon_v2_pokemonspecy {
          __typename
          generation: pokemon_v2_generation {
            __typename
            name
          }
          isLegendary: is_legendary
          isMythical: is_mythical
          captureRate: capture_rate
          isFormSwitchable: forms_switchable
          genderRate: gender_rate
          hasGenderDiff: has_gender_differences
          evolutions: pokemon_v2_evolutionchain {
            __typename
            info: pokemon_v2_pokemonspecies(order_by: {order: asc_nulls_first}) {
              __typename
              name
              previousEvolution: evolves_from_species_id
              evolutionDetails: pokemon_v2_pokemonevolutions(distinct_on: id) {
                __typename
                trigger: pokemon_v2_evolutiontrigger {
                  __typename
                  name
                }
                minLvl: min_level
                neededTime: time_of_day
                neededHappiness: min_happiness
                neededAffection: min_affection
                needsRain: needs_overworld_rain
                neededLocation: pokemon_v2_location {
                  __typename
                  name
                }
                neededGender: pokemon_v2_gender {
                  __typename
                  name
                }
                neededItem: pokemon_v2_item {
                  __typename
                  name
                }
              }
            }
          }
          pokeForms: pokemon_v2_pokemons(distinct_on: id, where: {id: {_neq: $id}}) {
            __typename
            id
            name
            height
            weight
            formDetails: pokemon_v2_pokemonforms(
              distinct_on: form_name
              where: {form_name: {_neq: ""}}
            ) {
              __typename
              formName: form_name
            }
            typeDetails: pokemon_v2_pokemontypes {
              __typename
              types: pokemon_v2_type {
                __typename
                name
              }
            }
            abilities: pokemon_v2_pokemonabilities(order_by: {slot: asc_nulls_first}) {
              __typename
              slot
              ability: pokemon_v2_ability {
                __typename
                name
              }
            }
            stats: pokemon_v2_pokemonstats {
              __typename
              stat: pokemon_v2_stat {
                __typename
                name
              }
              base: base_stat
            }
          }
        }
      }
    }
    """

  public let operationName: String = "pokemonDetails"

  public var id: Int

  public init(id: Int) {
    self.id = id
  }

  public var variables: GraphQLMap? {
    return ["id": id]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["query_root"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("pokemon_v2_pokemon_by_pk", alias: "pokemon", arguments: ["id": GraphQLVariable("id")], type: .object(Pokemon.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pokemon: Pokemon? = nil) {
      self.init(unsafeResultMap: ["__typename": "query_root", "pokemon": pokemon.flatMap { (value: Pokemon) -> ResultMap in value.resultMap }])
    }

    /// fetch data from the table: "pokemon_v2_pokemon" using primary key columns
    public var pokemon: Pokemon? {
      get {
        return (resultMap["pokemon"] as? ResultMap).flatMap { Pokemon(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "pokemon")
      }
    }

    public struct Pokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["pokemon_v2_pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("height", type: .scalar(Int.self)),
          GraphQLField("weight", type: .scalar(Int.self)),
          GraphQLField("pokemon_v2_pokemontypes", alias: "typeDetails", type: .nonNull(.list(.nonNull(.object(TypeDetail.selections))))),
          GraphQLField("pokemon_v2_pokemonabilities", alias: "abilities", arguments: ["order_by": ["slot": "asc_nulls_first"]], type: .nonNull(.list(.nonNull(.object(Ability.selections))))),
          GraphQLField("pokemon_v2_pokemonstats", alias: "stats", type: .nonNull(.list(.nonNull(.object(Stat.selections))))),
          GraphQLField("pokemon_v2_pokemonspecy", alias: "species", type: .object(Species.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, height: Int? = nil, weight: Int? = nil, typeDetails: [TypeDetail], abilities: [Ability], stats: [Stat], species: Species? = nil) {
        self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemon", "name": name, "height": height, "weight": weight, "typeDetails": typeDetails.map { (value: TypeDetail) -> ResultMap in value.resultMap }, "abilities": abilities.map { (value: Ability) -> ResultMap in value.resultMap }, "stats": stats.map { (value: Stat) -> ResultMap in value.resultMap }, "species": species.flatMap { (value: Species) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var height: Int? {
        get {
          return resultMap["height"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "height")
        }
      }

      public var weight: Int? {
        get {
          return resultMap["weight"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }

      /// An array relationship
      public var typeDetails: [TypeDetail] {
        get {
          return (resultMap["typeDetails"] as! [ResultMap]).map { (value: ResultMap) -> TypeDetail in TypeDetail(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: TypeDetail) -> ResultMap in value.resultMap }, forKey: "typeDetails")
        }
      }

      /// An array relationship
      public var abilities: [Ability] {
        get {
          return (resultMap["abilities"] as! [ResultMap]).map { (value: ResultMap) -> Ability in Ability(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Ability) -> ResultMap in value.resultMap }, forKey: "abilities")
        }
      }

      /// An array relationship
      public var stats: [Stat] {
        get {
          return (resultMap["stats"] as! [ResultMap]).map { (value: ResultMap) -> Stat in Stat(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Stat) -> ResultMap in value.resultMap }, forKey: "stats")
        }
      }

      /// An object relationship
      public var species: Species? {
        get {
          return (resultMap["species"] as? ResultMap).flatMap { Species(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "species")
        }
      }

      public struct TypeDetail: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_pokemontype"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pokemon_v2_type", alias: "types", type: .object(`Type`.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(types: `Type`? = nil) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemontype", "types": types.flatMap { (value: `Type`) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// An object relationship
        public var types: `Type`? {
          get {
            return (resultMap["types"] as? ResultMap).flatMap { `Type`(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "types")
          }
        }

        public struct `Type`: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_type"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_type", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Ability: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_pokemonability"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("slot", type: .nonNull(.scalar(Int.self))),
            GraphQLField("pokemon_v2_ability", alias: "ability", type: .object(Ability.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(slot: Int, ability: Ability? = nil) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonability", "slot": slot, "ability": ability.flatMap { (value: Ability) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var slot: Int {
          get {
            return resultMap["slot"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "slot")
          }
        }

        /// An object relationship
        public var ability: Ability? {
          get {
            return (resultMap["ability"] as? ResultMap).flatMap { Ability(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "ability")
          }
        }

        public struct Ability: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_ability"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_ability", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Stat: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_pokemonstat"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pokemon_v2_stat", alias: "stat", type: .object(Stat.selections)),
            GraphQLField("base_stat", alias: "base", type: .nonNull(.scalar(Int.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(stat: Stat? = nil, base: Int) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonstat", "stat": stat.flatMap { (value: Stat) -> ResultMap in value.resultMap }, "base": base])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// An object relationship
        public var stat: Stat? {
          get {
            return (resultMap["stat"] as? ResultMap).flatMap { Stat(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "stat")
          }
        }

        public var base: Int {
          get {
            return resultMap["base"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "base")
          }
        }

        public struct Stat: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_stat"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_stat", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Species: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["pokemon_v2_pokemonspecies"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("pokemon_v2_generation", alias: "generation", type: .object(Generation.selections)),
            GraphQLField("is_legendary", alias: "isLegendary", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("is_mythical", alias: "isMythical", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("capture_rate", alias: "captureRate", type: .scalar(Int.self)),
            GraphQLField("forms_switchable", alias: "isFormSwitchable", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("gender_rate", alias: "genderRate", type: .scalar(Int.self)),
            GraphQLField("has_gender_differences", alias: "hasGenderDiff", type: .nonNull(.scalar(Bool.self))),
            GraphQLField("pokemon_v2_evolutionchain", alias: "evolutions", type: .object(Evolution.selections)),
            GraphQLField("pokemon_v2_pokemons", alias: "pokeForms", arguments: ["distinct_on": "id", "where": ["id": ["_neq": GraphQLVariable("id")]]], type: .nonNull(.list(.nonNull(.object(PokeForm.selections))))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(generation: Generation? = nil, isLegendary: Bool, isMythical: Bool, captureRate: Int? = nil, isFormSwitchable: Bool, genderRate: Int? = nil, hasGenderDiff: Bool, evolutions: Evolution? = nil, pokeForms: [PokeForm]) {
          self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonspecies", "generation": generation.flatMap { (value: Generation) -> ResultMap in value.resultMap }, "isLegendary": isLegendary, "isMythical": isMythical, "captureRate": captureRate, "isFormSwitchable": isFormSwitchable, "genderRate": genderRate, "hasGenderDiff": hasGenderDiff, "evolutions": evolutions.flatMap { (value: Evolution) -> ResultMap in value.resultMap }, "pokeForms": pokeForms.map { (value: PokeForm) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// An object relationship
        public var generation: Generation? {
          get {
            return (resultMap["generation"] as? ResultMap).flatMap { Generation(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "generation")
          }
        }

        public var isLegendary: Bool {
          get {
            return resultMap["isLegendary"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isLegendary")
          }
        }

        public var isMythical: Bool {
          get {
            return resultMap["isMythical"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isMythical")
          }
        }

        public var captureRate: Int? {
          get {
            return resultMap["captureRate"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "captureRate")
          }
        }

        public var isFormSwitchable: Bool {
          get {
            return resultMap["isFormSwitchable"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isFormSwitchable")
          }
        }

        public var genderRate: Int? {
          get {
            return resultMap["genderRate"] as? Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "genderRate")
          }
        }

        public var hasGenderDiff: Bool {
          get {
            return resultMap["hasGenderDiff"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "hasGenderDiff")
          }
        }

        /// An object relationship
        public var evolutions: Evolution? {
          get {
            return (resultMap["evolutions"] as? ResultMap).flatMap { Evolution(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "evolutions")
          }
        }

        /// An array relationship
        public var pokeForms: [PokeForm] {
          get {
            return (resultMap["pokeForms"] as! [ResultMap]).map { (value: ResultMap) -> PokeForm in PokeForm(unsafeResultMap: value) }
          }
          set {
            resultMap.updateValue(newValue.map { (value: PokeForm) -> ResultMap in value.resultMap }, forKey: "pokeForms")
          }
        }

        public struct Generation: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_generation"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_generation", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }

        public struct Evolution: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_evolutionchain"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("pokemon_v2_pokemonspecies", alias: "info", arguments: ["order_by": ["order": "asc_nulls_first"]], type: .nonNull(.list(.nonNull(.object(Info.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(info: [Info]) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_evolutionchain", "info": info.map { (value: Info) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// An array relationship
          public var info: [Info] {
            get {
              return (resultMap["info"] as! [ResultMap]).map { (value: ResultMap) -> Info in Info(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Info) -> ResultMap in value.resultMap }, forKey: "info")
            }
          }

          public struct Info: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["pokemon_v2_pokemonspecies"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("name", type: .nonNull(.scalar(String.self))),
                GraphQLField("evolves_from_species_id", alias: "previousEvolution", type: .scalar(Int.self)),
                GraphQLField("pokemon_v2_pokemonevolutions", alias: "evolutionDetails", arguments: ["distinct_on": "id"], type: .nonNull(.list(.nonNull(.object(EvolutionDetail.selections))))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(name: String, previousEvolution: Int? = nil, evolutionDetails: [EvolutionDetail]) {
              self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonspecies", "name": name, "previousEvolution": previousEvolution, "evolutionDetails": evolutionDetails.map { (value: EvolutionDetail) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var name: String {
              get {
                return resultMap["name"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "name")
              }
            }

            public var previousEvolution: Int? {
              get {
                return resultMap["previousEvolution"] as? Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "previousEvolution")
              }
            }

            /// An array relationship
            public var evolutionDetails: [EvolutionDetail] {
              get {
                return (resultMap["evolutionDetails"] as! [ResultMap]).map { (value: ResultMap) -> EvolutionDetail in EvolutionDetail(unsafeResultMap: value) }
              }
              set {
                resultMap.updateValue(newValue.map { (value: EvolutionDetail) -> ResultMap in value.resultMap }, forKey: "evolutionDetails")
              }
            }

            public struct EvolutionDetail: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["pokemon_v2_pokemonevolution"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("pokemon_v2_evolutiontrigger", alias: "trigger", type: .object(Trigger.selections)),
                  GraphQLField("min_level", alias: "minLvl", type: .scalar(Int.self)),
                  GraphQLField("time_of_day", alias: "neededTime", type: .scalar(String.self)),
                  GraphQLField("min_happiness", alias: "neededHappiness", type: .scalar(Int.self)),
                  GraphQLField("min_affection", alias: "neededAffection", type: .scalar(Int.self)),
                  GraphQLField("needs_overworld_rain", alias: "needsRain", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("pokemon_v2_location", alias: "neededLocation", type: .object(NeededLocation.selections)),
                  GraphQLField("pokemon_v2_gender", alias: "neededGender", type: .object(NeededGender.selections)),
                  GraphQLField("pokemon_v2_item", alias: "neededItem", type: .object(NeededItem.selections)),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(trigger: Trigger? = nil, minLvl: Int? = nil, neededTime: String? = nil, neededHappiness: Int? = nil, neededAffection: Int? = nil, needsRain: Bool, neededLocation: NeededLocation? = nil, neededGender: NeededGender? = nil, neededItem: NeededItem? = nil) {
                self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonevolution", "trigger": trigger.flatMap { (value: Trigger) -> ResultMap in value.resultMap }, "minLvl": minLvl, "neededTime": neededTime, "neededHappiness": neededHappiness, "neededAffection": neededAffection, "needsRain": needsRain, "neededLocation": neededLocation.flatMap { (value: NeededLocation) -> ResultMap in value.resultMap }, "neededGender": neededGender.flatMap { (value: NeededGender) -> ResultMap in value.resultMap }, "neededItem": neededItem.flatMap { (value: NeededItem) -> ResultMap in value.resultMap }])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// An object relationship
              public var trigger: Trigger? {
                get {
                  return (resultMap["trigger"] as? ResultMap).flatMap { Trigger(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "trigger")
                }
              }

              public var minLvl: Int? {
                get {
                  return resultMap["minLvl"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "minLvl")
                }
              }

              public var neededTime: String? {
                get {
                  return resultMap["neededTime"] as? String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "neededTime")
                }
              }

              public var neededHappiness: Int? {
                get {
                  return resultMap["neededHappiness"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "neededHappiness")
                }
              }

              public var neededAffection: Int? {
                get {
                  return resultMap["neededAffection"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "neededAffection")
                }
              }

              public var needsRain: Bool {
                get {
                  return resultMap["needsRain"]! as! Bool
                }
                set {
                  resultMap.updateValue(newValue, forKey: "needsRain")
                }
              }

              /// An object relationship
              public var neededLocation: NeededLocation? {
                get {
                  return (resultMap["neededLocation"] as? ResultMap).flatMap { NeededLocation(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "neededLocation")
                }
              }

              /// An object relationship
              public var neededGender: NeededGender? {
                get {
                  return (resultMap["neededGender"] as? ResultMap).flatMap { NeededGender(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "neededGender")
                }
              }

              /// An object relationship
              public var neededItem: NeededItem? {
                get {
                  return (resultMap["neededItem"] as? ResultMap).flatMap { NeededItem(unsafeResultMap: $0) }
                }
                set {
                  resultMap.updateValue(newValue?.resultMap, forKey: "neededItem")
                }
              }

              public struct Trigger: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["pokemon_v2_evolutiontrigger"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(name: String) {
                  self.init(unsafeResultMap: ["__typename": "pokemon_v2_evolutiontrigger", "name": name])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }
              }

              public struct NeededLocation: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["pokemon_v2_location"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(name: String) {
                  self.init(unsafeResultMap: ["__typename": "pokemon_v2_location", "name": name])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }
              }

              public struct NeededGender: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["pokemon_v2_gender"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(name: String) {
                  self.init(unsafeResultMap: ["__typename": "pokemon_v2_gender", "name": name])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }
              }

              public struct NeededItem: GraphQLSelectionSet {
                public static let possibleTypes: [String] = ["pokemon_v2_item"]

                public static var selections: [GraphQLSelection] {
                  return [
                    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                    GraphQLField("name", type: .nonNull(.scalar(String.self))),
                  ]
                }

                public private(set) var resultMap: ResultMap

                public init(unsafeResultMap: ResultMap) {
                  self.resultMap = unsafeResultMap
                }

                public init(name: String) {
                  self.init(unsafeResultMap: ["__typename": "pokemon_v2_item", "name": name])
                }

                public var __typename: String {
                  get {
                    return resultMap["__typename"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                  }
                }

                public var name: String {
                  get {
                    return resultMap["name"]! as! String
                  }
                  set {
                    resultMap.updateValue(newValue, forKey: "name")
                  }
                }
              }
            }
          }
        }

        public struct PokeForm: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["pokemon_v2_pokemon"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("height", type: .scalar(Int.self)),
              GraphQLField("weight", type: .scalar(Int.self)),
              GraphQLField("pokemon_v2_pokemonforms", alias: "formDetails", arguments: ["distinct_on": "form_name", "where": ["form_name": ["_neq": ""]]], type: .nonNull(.list(.nonNull(.object(FormDetail.selections))))),
              GraphQLField("pokemon_v2_pokemontypes", alias: "typeDetails", type: .nonNull(.list(.nonNull(.object(TypeDetail.selections))))),
              GraphQLField("pokemon_v2_pokemonabilities", alias: "abilities", arguments: ["order_by": ["slot": "asc_nulls_first"]], type: .nonNull(.list(.nonNull(.object(Ability.selections))))),
              GraphQLField("pokemon_v2_pokemonstats", alias: "stats", type: .nonNull(.list(.nonNull(.object(Stat.selections))))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String, height: Int? = nil, weight: Int? = nil, formDetails: [FormDetail], typeDetails: [TypeDetail], abilities: [Ability], stats: [Stat]) {
            self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemon", "id": id, "name": name, "height": height, "weight": weight, "formDetails": formDetails.map { (value: FormDetail) -> ResultMap in value.resultMap }, "typeDetails": typeDetails.map { (value: TypeDetail) -> ResultMap in value.resultMap }, "abilities": abilities.map { (value: Ability) -> ResultMap in value.resultMap }, "stats": stats.map { (value: Stat) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int {
            get {
              return resultMap["id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var height: Int? {
            get {
              return resultMap["height"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "height")
            }
          }

          public var weight: Int? {
            get {
              return resultMap["weight"] as? Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "weight")
            }
          }

          /// An array relationship
          public var formDetails: [FormDetail] {
            get {
              return (resultMap["formDetails"] as! [ResultMap]).map { (value: ResultMap) -> FormDetail in FormDetail(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: FormDetail) -> ResultMap in value.resultMap }, forKey: "formDetails")
            }
          }

          /// An array relationship
          public var typeDetails: [TypeDetail] {
            get {
              return (resultMap["typeDetails"] as! [ResultMap]).map { (value: ResultMap) -> TypeDetail in TypeDetail(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: TypeDetail) -> ResultMap in value.resultMap }, forKey: "typeDetails")
            }
          }

          /// An array relationship
          public var abilities: [Ability] {
            get {
              return (resultMap["abilities"] as! [ResultMap]).map { (value: ResultMap) -> Ability in Ability(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Ability) -> ResultMap in value.resultMap }, forKey: "abilities")
            }
          }

          /// An array relationship
          public var stats: [Stat] {
            get {
              return (resultMap["stats"] as! [ResultMap]).map { (value: ResultMap) -> Stat in Stat(unsafeResultMap: value) }
            }
            set {
              resultMap.updateValue(newValue.map { (value: Stat) -> ResultMap in value.resultMap }, forKey: "stats")
            }
          }

          public struct FormDetail: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["pokemon_v2_pokemonform"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("form_name", alias: "formName", type: .nonNull(.scalar(String.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(formName: String) {
              self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonform", "formName": formName])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var formName: String {
              get {
                return resultMap["formName"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "formName")
              }
            }
          }

          public struct TypeDetail: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["pokemon_v2_pokemontype"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("pokemon_v2_type", alias: "types", type: .object(`Type`.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(types: `Type`? = nil) {
              self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemontype", "types": types.flatMap { (value: `Type`) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// An object relationship
            public var types: `Type`? {
              get {
                return (resultMap["types"] as? ResultMap).flatMap { `Type`(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "types")
              }
            }

            public struct `Type`: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["pokemon_v2_type"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String) {
                self.init(unsafeResultMap: ["__typename": "pokemon_v2_type", "name": name])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }
            }
          }

          public struct Ability: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["pokemon_v2_pokemonability"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("slot", type: .nonNull(.scalar(Int.self))),
                GraphQLField("pokemon_v2_ability", alias: "ability", type: .object(Ability.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(slot: Int, ability: Ability? = nil) {
              self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonability", "slot": slot, "ability": ability.flatMap { (value: Ability) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var slot: Int {
              get {
                return resultMap["slot"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "slot")
              }
            }

            /// An object relationship
            public var ability: Ability? {
              get {
                return (resultMap["ability"] as? ResultMap).flatMap { Ability(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "ability")
              }
            }

            public struct Ability: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["pokemon_v2_ability"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String) {
                self.init(unsafeResultMap: ["__typename": "pokemon_v2_ability", "name": name])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }
            }
          }

          public struct Stat: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["pokemon_v2_pokemonstat"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("pokemon_v2_stat", alias: "stat", type: .object(Stat.selections)),
                GraphQLField("base_stat", alias: "base", type: .nonNull(.scalar(Int.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(stat: Stat? = nil, base: Int) {
              self.init(unsafeResultMap: ["__typename": "pokemon_v2_pokemonstat", "stat": stat.flatMap { (value: Stat) -> ResultMap in value.resultMap }, "base": base])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            /// An object relationship
            public var stat: Stat? {
              get {
                return (resultMap["stat"] as? ResultMap).flatMap { Stat(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "stat")
              }
            }

            public var base: Int {
              get {
                return resultMap["base"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "base")
              }
            }

            public struct Stat: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["pokemon_v2_stat"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("name", type: .nonNull(.scalar(String.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(name: String) {
                self.init(unsafeResultMap: ["__typename": "pokemon_v2_stat", "name": name])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var name: String {
                get {
                  return resultMap["name"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "name")
                }
              }
            }
          }
        }
      }
    }
  }
}
