//
//  AuthenticationUseCaseMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class AuthenticationUseCaseMock: AuthenticationUseCaseProtocol {
    
    func getCurrentUser() -> UserModel? {
        .init(email: "emailTest@email.com")
    }
    
    func userLogin(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func loginFacebook(completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func loginGoogle(completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    
}
