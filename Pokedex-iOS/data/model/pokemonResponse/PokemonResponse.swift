//
//  PokemonResponse.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

struct PokemonResponse: Decodable {
    let name: String
    let id: Int
    let color: PokemonColorResponse
    let evolution_chain: EvolutionChainResponse
}
