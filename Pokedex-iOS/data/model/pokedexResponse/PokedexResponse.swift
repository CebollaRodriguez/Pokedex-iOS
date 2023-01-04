//
//  PokedexResponse.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

struct PokedexResponse: Decodable {
    let name: String
    let pokemonList: [PokedexModel]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case pokemonList = "pokemon_entries"
    }
}

struct PokedexModel: Decodable {
    let pokemonId: Int
    let pokemonInPokedex: PokemonInPokedexModel
    
    enum Codingkeys: String, CodingKey {
        case pokemonId = "entry_number"
        case pokemonInPokedex = "pokemon_species"
    }
    
}

struct PokemonInPokedexModel: Decodable {
    let name: String
    let url: String
}
