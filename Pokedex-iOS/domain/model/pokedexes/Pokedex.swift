//
//  Pokedex.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

struct Pokedex {
    var pokedexName: String
    let pokemons: [PokemonInPokedex]
}

struct PokemonInPokedex {
    let id: Int
    var name: String
    let url: String
}
