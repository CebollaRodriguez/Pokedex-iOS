//
//  PokedexService.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

class PokedexService: PokedexServiceProtocol {
    private let api: PokemonApiProtocol
    
    init(api: PokemonApiProtocol) {
        self.api = api
    }
    
    func getPokedexesList(completion: @escaping(Result<ListPokedexesResponse?, Error>) -> Void) {
        api.listPokedexes(completion: completion)
    }
    
    func getOnePokedex(url: String, completion: @escaping(Result<PokedexResponse?, Error>) -> Void) {
        api.onePokedex(url: url, completion: completion)
    }
}
