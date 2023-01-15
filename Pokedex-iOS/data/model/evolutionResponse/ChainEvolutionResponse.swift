//
//  ChainEvolutionResponse.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 15/01/23.
//

import Foundation

struct ChainEvolutionResponse: Decodable {
    let evolves_to: [ChainEvolutionResponse]
    let species: PokemonInPokedexModel
}
