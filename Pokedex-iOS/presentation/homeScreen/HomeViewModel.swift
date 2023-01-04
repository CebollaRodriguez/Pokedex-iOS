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
    private let useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
    }
    
    func getPokedexeslist() {
        useCase.getPokexesList { [weak self] result in
            switch result {
            case .success(let pokedexList):
                self?.pokedexes = pokedexList
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}

extension HomeViewModel {
    static func build() -> HomeViewModel{
        return HomeViewModel(useCase: HomeUseCase())
    }
}
