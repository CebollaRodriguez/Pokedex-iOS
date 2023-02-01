//
//  ExploreViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var userExplore: UserExplore = .init(latitude: -23.58, longitude: -46.68)
    @Published var messageError: String = ""
    @Published var isLocationAuthorized: Bool = false
    @Published var distanceTravel: Int = 0
    @Published var isGoalComplete: Bool = false
    @Published var pokemonFounded: PokemonInPokedex? = nil
    
    private var pokedexList: [PokemonInPokedex] = []
    
    private let useCase: ExploreUseCaseProtocol
    
    init(useCase: ExploreUseCaseProtocol) {
        self.useCase = useCase
        
    }
    
    func getCurrentLocation() {
        useCase.getCurrentLocation { [weak self] result in
            switch result {
            case .success(let userModel):
                self?.userExplore = userModel
                self?.checkLocationPermission()
                
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    private func checkLocationPermission() {
        guard let status = useCase.checkLocationPermission() else { return }
        self.isLocationAuthorized = status
    }
    
    func getDistance() {
        useCase.getDistance { [weak self] distance in
            
            self?.distanceTravel = Int(distance.rounded(.down))
            
            if self?.distanceTravel ?? 0 >= 100  {
                self?.showPokemonFounded()
                if self?.pokemonFounded != nil {
                    self?.isGoalComplete = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    self?.isGoalComplete = false
                    self?.pokemonFounded = nil
                    
                }
            }
        }
    }
    
    func stopTracking() {
        useCase.stopTracking()
    }
    
    func showPokemonFounded() {
        let randomIndex = pokedexList.indices.randomElement()!
        self.pokemonFounded = pokedexList[randomIndex]
    }
    
    func getPokedexList() {
        useCase.getPokedexList { [weak self] result in
            switch result {
            case .success(let pokedex):
                self?.pokedexList = pokedex.pokemons
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
