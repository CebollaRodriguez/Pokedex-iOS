//
//  PokedexUseCaseMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokedexUseCaseMock: PokedexUseCaseProtocol {
    func getOnePokedex(url: String, completion: @escaping (Result<Pokedex, Error>) -> Void) {
        completion(.success(.init(pokedexName: "Test", pokemons: [])))
    }
}
