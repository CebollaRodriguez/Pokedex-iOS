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
        useCase.getDistance { [weak self]distance in
            
            self?.distanceTravel = Int(distance.rounded(.down))
        }
    }
}
