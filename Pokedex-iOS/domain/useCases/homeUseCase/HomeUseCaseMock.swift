//
//  HomeUseCaseMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class HomeUseCaseMock: HomeUseCaseProtocol {
    func getPokexesList(completion: @escaping (Result<[Pokedexes], Error>) -> Void) {
        completion(.success([.init(name: "Test", url: "UrlTest")]))
    }
}
