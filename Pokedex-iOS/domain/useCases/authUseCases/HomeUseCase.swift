//
//  HomeUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

final class HomeUseCase {
    
    private let authRepository: AuthenticationService
    
    init(authRepository: AuthenticationService = AuthenticationService()) {
        self.authRepository = authRepository
    }
    
    func userLogOut() throws {
        try authRepository.userLogOut()
    }
}
