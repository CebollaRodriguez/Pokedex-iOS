//
//  AuthenticationUseCase.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

final class AuthenticationUseCase {
    private let authService: AuthenticationService
    
    init(authService: AuthenticationService = AuthenticationService()) {
        self.authService = authService
    }
    
    func getCurrentUser()-> UserModel? {
        return authService.currentUser()
    }
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        authService.userLogin(email: email, password: password, completion: completion)
    }
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void){
        authService.createNewUser(email: email, password: password, completion: completion)
    }
    
    func loginFacebook(completion: @escaping(Result<UserModel, Error>) -> Void) {
        authService.loginFacebook(completion: completion)
    }
    
    func loginGoogle(completion: @escaping(Result<UserModel, Error>) -> Void) {
        authService.loginGoogle(completion: completion)
    }
    
}
