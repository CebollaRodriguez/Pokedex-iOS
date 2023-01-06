//
//  HomeUseCaseProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol HomeUseCaseProtocol: AnyObject {
    func getPokexesList(completion: @escaping(Result<[Pokedexes], Error>) -> Void)
}
