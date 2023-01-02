//
//  SplashUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

final class SplashUseCase {
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = AuthenticationService()) {
        self.authService = authService
    }
    
    func getCurrentSession() -> User? {
        guard let userModel = authService.getCurrentUser() else { return nil }
        return User(email: userModel.email)
    }
}
