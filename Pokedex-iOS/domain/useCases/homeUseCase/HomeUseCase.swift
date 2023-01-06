//
//  HomeUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

final class HomeUseCase: HomeUseCaseProtocol {
    
    private let pokedexService: PokedexService
    
    init(pokedexService: PokedexService = PokedexService()) {
        self.pokedexService = pokedexService
    }
    
    func getPokexesList(completion: @escaping(Result<[Pokedexes], Error>) -> Void) {
        pokedexService.getPokedexesList { result in
            switch result {
            case .success(let pokedexesResponse):
                if let pokedexesModel = pokedexesResponse?.results {
                    let pokedexes = pokedexesModel.map{ pokedex in
                        Pokedexes.init(name: pokedex.name, url: pokedex.url)
                    }
                    completion(.success(pokedexes))
                    
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
