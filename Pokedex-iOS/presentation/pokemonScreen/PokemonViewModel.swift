//
//  PokemonViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation
import SwiftUI

class PokemonViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var id: Int = 0
    @Published var pokemonEvolution: [PokemonEvolutions] = []
    @Published var color: Color? = nil
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
                self?.id = pokemon.id
                self?.pokemonEvolution = pokemon.pokemonEvolutions
                self?.color = self?.getColor(. init(rawValue: pokemon.color) ?? .unowned)
                self?.name = (self?.name.firstUpper())!
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    private func getColor(_ color: PokemonColor) -> Color? {
        switch color {
        case . green:
            return .green
        case . black:
            return .black
        case .blue:
            return .blue
        case .brown:
            return .brown
        case .gray:
            return .gray
        case .unowned:
            return nil
        }
    }
}
