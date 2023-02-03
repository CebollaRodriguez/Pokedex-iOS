//
//  PokemonServiceMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokemonServiceMock: PokemonServiceProtocol {
    func getEvolution(url: String, completion: @escaping (Result<EvolutionResponse, Error>) -> Void) {
        
    }
    
    func getOnePokemon(id: Int, completion: @escaping (Result<PokemonResponse, Error>) -> Void) {
        completion(.success(.init(name: "test", id: 1, color: .init(name: "ColorTest"), evolution_chain: .init(url: "UrlTest"))))
    }
}
