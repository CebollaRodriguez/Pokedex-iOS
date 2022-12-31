//
//  AuthenticationUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

final class AuthenticationUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    func getCurrentUser()-> UserModel? {
        return authRepository.getCurrentUser()
    }
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        authRepository.userLogin(email: email, password: password, completion: completion)
    }
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void){
        authRepository.createNewUser(email: email, password: password, completion: completion)
    }
}
