//
//  ProfileUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

final class ProfileUseCase {
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = AuthenticationService()) {
        self.authService = authService
    }
    
    func getCurrentProvider() -> [LinkedAccountModel] {
        return authService.getCurrentProvider()
    }
    
    func userLogOut() throws {
        try authService.userLogOut()
    }
}
