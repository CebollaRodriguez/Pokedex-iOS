//
//  PokedexViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

class PokedexViewModel: ObservableObject {
    @Published var model: Pokedex = .init(pokedexName: "S/N", pokemons: [])
    @Published var messageError: String = ""
    private let useCase: PokedexUseCase
    
    init(useCase: PokedexUseCase) {
        self.useCase = useCase
    }
    
    func getPokedex(url: String) {
        useCase.getOnePokedex(url: url) { [weak self] result in
            switch result {
            case .success(let pokedex):
                self?.model = pokedex
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}

extension PokedexViewModel {
    static func build() -> PokedexViewModel {
        return PokedexViewModel(useCase: PokedexUseCase())
    }
}
