//
//  AuthenticationServiceMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class AuthenticationServiceMock: AuthenticationServiceProtocol {
    func currentUser() -> UserModel? {
        .init(email: "emailTest@email.com")
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func userLogin(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func loginFacebook(completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func loginGoogle(completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func userLogOut() throws {
        print("User LogOut")
    }
    
    func currentProvider() -> [LinkedAccountModel] {
        [.emailAndPaswword]
    }
    
    func linkFacebook(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func linkGoogle(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func linkEmailAndPassword(email: String, password: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func deleteAccount(completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
}
