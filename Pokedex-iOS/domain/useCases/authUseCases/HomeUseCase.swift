//
//  HomeUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

final class HomeUseCase {
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    func userLogOut() throws {
        try authRepository.userLogOut()
    }
}
