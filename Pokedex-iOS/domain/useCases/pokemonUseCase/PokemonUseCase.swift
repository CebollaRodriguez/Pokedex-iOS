//
//  PokemonUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokemonUseCase: PokemonUseCaseProtocol {
    private let pokemonService: PokemonServiceProtocol
    
    init(pokemonService: PokemonServiceProtocol) {
        self.pokemonService = pokemonService
    }
    
    func getPokemon(id: Int, completion: @escaping(Result<Pokemon, Error>) -> Void) {
        pokemonService.getOnePokemon(id: id) { result in
            switch result {
            case .success(let pokemonResponse):
                completion(.success(.init(name: pokemonResponse.name, id: pokemonResponse.id, color: pokemonResponse.color.name, evolutionChainUrl: pokemonResponse.evolution_chain.url)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
