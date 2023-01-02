//
//  ProfileViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    private let useCase: ProfileUseCase
    
    init(profileUseCase: ProfileUseCase) {
        self.useCase = profileUseCase
    }
    
    func userLogOut() {
        do {
            try useCase.userLogOut()
            
        } catch {
            print("Error logout")
        }
    }
}

extension ProfileViewModel {
    static func build() -> ProfileViewModel {
        return ProfileViewModel(profileUseCase: ProfileUseCase())
    }
}
