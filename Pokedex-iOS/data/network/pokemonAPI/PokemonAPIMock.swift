//
//  PokemonAPIMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class PokemonAPIMock: PokemonApiProtocol {
    func getEvolutionSpecies(url: String, completion: @escaping (Result<EvolutionResponse?, Error>) -> Void) {
        
    }
    
    func listPokedexes(completion: @escaping (Result<ListPokedexesResponse?, Error>) -> Void) {
        completion(.success(.init(results: [.init(name: "Test", url: "UrlTest")])))
    }
    
    func onePokedex(url: String, completion: @escaping (Result<PokedexResponse?, Error>) -> Void) {
        completion(.success(.init(name: "Test", pokemon_entries: [])))
    }
    
    func getOnePokemon(id: Int, completion: @escaping (Result<PokemonResponse?, Error>) -> Void) {
        completion(.success(.init(name: "Test", id: 2, color: .init(name: "colorTest"), evolution_chain: .init(url: "UrlTest"))))
    }
    
    
}
