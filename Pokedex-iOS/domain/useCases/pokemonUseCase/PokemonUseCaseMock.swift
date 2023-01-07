//
//  PokemonUseCaseMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokemonUseCaseMock: PokemonUseCaseProtocol {
    func getPokemon(id: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        completion(.success(.init(name: "Teste", id: 1, color: "ColorTest", evolutionChainUrl: "UrlTest")))
    }
}
