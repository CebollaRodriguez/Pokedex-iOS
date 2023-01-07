//
//  PokedexUseCaseProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol PokedexUseCaseProtocol: AnyObject {
    func getOnePokedex(url: String, completion: @escaping(Result<Pokedex, Error>) -> Void)
}
