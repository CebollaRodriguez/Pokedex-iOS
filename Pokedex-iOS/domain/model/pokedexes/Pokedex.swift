//
//  Pokedex.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

struct Pokedex {
    let pokedexName: String
    let pokemons: [PokemonInPokedex]
}

struct PokemonInPokedex {
    let id: Int
    let name: String
    let url: String
}
