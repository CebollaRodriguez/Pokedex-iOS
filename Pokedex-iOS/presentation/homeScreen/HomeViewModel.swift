//
//  HomeViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var pokedexes: [Pokedexes] = []
    @Published var messageError: String = ""
    @Published var pokedexesName: [String] = []
    @Published var selection: Pokedexes = .init(name: "", url: "")
    private let useCase: HomeUseCaseProtocol
    
    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func getPokedexeslist() {
        useCase.getPokexesList { [weak self] result in
            switch result {
            case .success(let pokedexList):
                self?.pokedexes = pokedexList.dropLast(pokedexList.count/2)
                self?.getPokedexesName(pokedexList)
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    private func getPokedexesName(_ list: [Pokedexes]) {
        selection = list.first ?? .init(name: "", url: "")
    }
}
