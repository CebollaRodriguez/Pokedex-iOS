//
//  Pokemon.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

struct Pokemon {
    let name: String
    let id: Int
    let color: String
    let evolutionChainUrl: String
    let pokemonEvolutions: [PokemonEvolutions]
}
