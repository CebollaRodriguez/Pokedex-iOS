//
//  PokemonClasses.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

extension PokedexService {
    static func build() -> PokedexService {
        return PokedexService(api: Constants.isMock ? PokemonAPIMock() : PokemonAPI() )
    }
}

extension PokemonService {
    static func build() -> PokemonService {
        return PokemonService(pokemonAPI: Constants.isMock ? PokemonAPIMock() : PokemonAPI() )
    }
}

