//
//  ExploreUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import Foundation

class ExploreUseCase: ExploreUseCaseProtocol {
    private let locationService: LocationServiceProtocol
    
    init(locationService: LocationServiceProtocol) {
        self.locationService = locationService
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
}
