//
//  PokedexServiceMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokedexServiceMock: PokedexServiceProtocol {
    func getPokedexesList(completion: @escaping (Result<ListPokedexesResponse?, Error>) -> Void) {
        completion(.success(.init(results: [.init(name: "Test", url: "UrlTest")])))
    }
    
    func getOnePokedex(url: String, completion: @escaping (Result<PokedexResponse?, Error>) -> Void) {
        completion(.success(.init(name: "Test", pokemon_entries: [])))
    }
}
