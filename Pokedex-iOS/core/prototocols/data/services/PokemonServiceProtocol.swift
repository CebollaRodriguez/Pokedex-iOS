//
//  PokemonServiceProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol PokemonServiceProtocol: AnyObject {
    
    func getOnePokemon(id: Int, completion: @escaping(Result<PokemonResponse, Error>) -> Void)
    
    func getEvolution(url: String, completion: @escaping(Result<EvolutionResponse, Error>) -> Void)
}
