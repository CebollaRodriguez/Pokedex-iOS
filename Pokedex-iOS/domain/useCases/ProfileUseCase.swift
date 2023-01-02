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
    
    func getCurrentProvider() -> [LinkedAccount] {
        return authService.currentProvider().map { model in
            LinkedAccount(rawValue: model.rawValue)
        }.compactMap{ $0 }
    }
    
    func userLogOut() throws {
        try authService.userLogOut()
    }
    
    func userLinkFAcebook(completion: @escaping(Bool) -> Void) {
        authService.linkFacebook(completion: completion)
    }
}
