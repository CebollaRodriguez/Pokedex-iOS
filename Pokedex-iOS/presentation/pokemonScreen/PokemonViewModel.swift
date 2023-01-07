//
//  PokemonViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

class PokemonViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var messageError: String = ""
    
    private let useCase: PokemonUseCaseProtocol
    
    
    init(useCase: PokemonUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func getPokemon(id: Int) {
        useCase.getPokemon(id: id) { [weak self] result in
            switch result {
            case .success(let pokemon):
                self?.name = pokemon.name
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}
