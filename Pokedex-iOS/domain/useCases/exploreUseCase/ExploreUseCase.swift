//
//  ExploreUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import Foundation

class ExploreUseCase: ExploreUseCaseProtocol {
    private let locationService: LocationServiceProtocol
    private let pokedexService: PokedexServiceProtocol
    
    init(locationService: LocationServiceProtocol, pokedexService: PokedexServiceProtocol) {
        self.locationService = locationService
        self.pokedexService = pokedexService
    }
    
    func getCurrentLocation(completion: @escaping (Result<UserExplore, Error>) -> Void) {
        locationService.getUserLocation(completion)
    }
    
    func checkLocationPermission()-> Bool? {
        locationService.checkLocationPermission()
    }
    
    func getDistance(completion: @escaping (Double) -> Void) {
        locationService.getDistance(completion: completion)
    }
    
    func stopTracking() {
        locationService.stopTracking()
    }
    
    func getPokedexList(completion: @escaping (Result <Pokedex, Error>) -> Void) {
        let randomPokedexId: Int = (1...20).randomElement()!
        let pokedexUrl: String = "https://pokeapi.co/api/v2/pokedex/\(randomPokedexId)/"
        pokedexService.getOnePokedex(url: pokedexUrl) { result in
            switch result {
            case .success(let pokedexSuccess):
                
                guard let pokedexResponse = pokedexSuccess else { return }
                let pokedex : Pokedex = .init(pokedexName: pokedexResponse.name, pokemons: pokedexResponse.pokemon_entries.map{ pokemon in
                    PokemonInPokedex(id: pokemon.entry_number, name: pokemon.pokemon_species.name, url: pokemon.pokemon_species.url)
                }.compactMap{ $0 })
                
                completion(.success(pokedex))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
