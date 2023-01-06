//
//  AuthenticationService.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation

final class AuthenticationService: AuthenticationServiceProtocol {
    private let firebaseAuthentication: FirebaseAuthenticationProtocol
    
    init(firebaseAuthentication: FirebaseAuthenticationProtocol) {
        self.firebaseAuthentication = firebaseAuthentication
    }
    
    func currentUser() -> UserModel? {
        firebaseAuthentication.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        firebaseAuthentication.createNewUser(email: email, password: password, completion: completion)
        
    }
    
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        firebaseAuthentication.userLogin(email: email, password: password, completion: completion)
        
    }
    
    func loginFacebook(completion: @escaping(Result<UserModel, Error>) -> Void) {
        firebaseAuthentication.loginWithFacebook(completion: completion)
    }
    
    func loginGoogle(completion: @escaping(Result<UserModel, Error>) -> Void) {
        firebaseAuthentication.loginWithGoogle(completion: completion)
    }
    
    func userLogOut() throws {
        try firebaseAuthentication.userLogOut()
    }
    
    func currentProvider() -> [LinkedAccountModel] {
        return firebaseAuthentication.currentProvider()
    }
    
    func linkFacebook(completion: @escaping(Bool) -> Void) {
        firebaseAuthentication.linkFacebook(completion: completion)
    }
    
    func linkGoogle(completion: @escaping(Bool) -> Void) {
        firebaseAuthentication.linkGoogle(completion: completion)
    }
    
    func linkEmailAndPassword(email: String, password: String, completion: @escaping(Bool) -> Void) {
        firebaseAuthentication.linkEmailAndPassword(email: email, password: password, completion: completion)
    }
    
    func deleteAccount(completion: @escaping(Result<Bool, Error>) -> Void) {
        firebaseAuthentication.deleteAccount(completion: completion)
    }
}
