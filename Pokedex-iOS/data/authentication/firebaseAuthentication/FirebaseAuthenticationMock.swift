//
//  FirebaseAuthenticationMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation
import FirebaseAuth

class FirebaseAuthenticationMock: FirebaseAuthenticationProtocol {
    func userLogin(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func getCurrentUser() -> UserModel? {
        .init(email: "emailTest@email.com")
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func loginWithFacebook(completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func loginWithGoogle(completion: @escaping (Result<UserModel, Error>) -> Void) {
        completion(.success(.init(email: "emailTest@email.com")))
    }
    
    func userLogOut() throws {
        print("User Log Out")
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
    
    func getCurrentCredential(completion: @escaping (AuthCredential?) -> Void) {
        completion(nil)
    }
    
    func linkEmailAndPassword(email: String, password: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func deleteAccount(completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    
}
