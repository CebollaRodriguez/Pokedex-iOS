//
//  SplashUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

class SplashUseCase: SplashUseCaseProtocol {
    private let authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol) {
        self.authService = authService
    }
    
    func getCurrentSession() -> User? {
        guard let userModel = authService.currentUser() else { return nil }
        return User(email: userModel.email)
    }
}
