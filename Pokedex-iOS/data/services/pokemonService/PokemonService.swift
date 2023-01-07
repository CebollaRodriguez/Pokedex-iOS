//
//  PokemonService.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokemonService: PokemonServiceProtocol {
    private let pokemonAPI : PokemonApiProtocol
    
    init(pokemonAPI: PokemonApiProtocol) {
        self.pokemonAPI = pokemonAPI
    }
    
    func getOnePokemon(id: Int, completion: @escaping(Result<PokemonResponse, Error>) -> Void) {
        pokemonAPI.getOnePokemon(id: id, completion: completion)
    }
}
