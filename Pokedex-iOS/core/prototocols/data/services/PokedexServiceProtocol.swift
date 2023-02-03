//
//  PokedexServiceProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol PokedexServiceProtocol: AnyObject {
    func getPokedexesList(completion: @escaping(Result<ListPokedexesResponse?, Error>) -> Void)
    
    func getOnePokedex(url: String, completion: @escaping(Result<PokedexResponse?, Error>) -> Void)
}
