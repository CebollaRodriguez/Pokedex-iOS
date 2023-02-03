//
//  PokedexUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

class PokedexUseCase: PokedexUseCaseProtocol {
    private let pokedexService: PokedexServiceProtocol
    
    init(pokedexService: PokedexServiceProtocol ) {
        self.pokedexService = pokedexService
    }
    
    func getOnePokedex(url: String, completion: @escaping(Result<Pokedex, Error>) -> Void) {
        pokedexService.getOnePokedex(url: url) { result in
            switch result {
            case .success(let response):
                if let pokedexResponse = response {
                    
                    let pokemonsList = pokedexResponse.pokemon_entries.map { pokedexModel in
                        PokemonInPokedex(id: pokedexModel.entry_number, name: pokedexModel.pokemon_species.name, url: pokedexModel.pokemon_species.url)
                    }
                    completion(.success(.init(pokedexName: pokedexResponse.name, pokemons: pokemonsList)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
