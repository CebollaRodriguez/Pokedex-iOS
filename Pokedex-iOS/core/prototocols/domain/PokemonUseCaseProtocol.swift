//
//  PokemonUseCaseProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol PokemonUseCaseProtocol: AnyObject {
    
    func getPokemon(id: Int, completion: @escaping(Result<Pokemon, Error>) -> Void)
}
