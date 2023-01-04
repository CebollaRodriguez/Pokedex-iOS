//
//  PokedexResponse.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

struct PokedexResponse: Decodable {
    let name: String
    let pokemon_entries: [PokedexModel]
    
    
}

struct PokedexModel: Decodable {
    let entry_number: Int
    let pokemon_species: PokemonInPokedexModel
    
    
    
}

struct PokemonInPokedexModel: Decodable {
    let name: String
    let url: String
}
/*
 enum CodingKeys: String, CodingKey {
     case name = "name"
     case pokemonList = "pokemon_entries"
 }
 
 enum Codingkeys: String, CodingKey {
     case pokemonId = "entry_number"
     case pokemonInPokedex = "pokemon_species"
 }
 */
