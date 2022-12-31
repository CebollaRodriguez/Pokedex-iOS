//
//  AuthRepository.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation

final class AuthRepository {
    private let firebaseAuthDataSource: FirebaseAuthDataSource
    
    init(firebaseAuthDataSource: FirebaseAuthDataSource = FirebaseAuthDataSource()) {
        self.firebaseAuthDataSource = firebaseAuthDataSource
    }
    
    func getCurrentUser() -> UserModel? {
        firebaseAuthDataSource.getCurrentUser()
    }
    
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        firebaseAuthDataSource.createNewUser(email: email, password: password, completion: completion)
        
    }
    
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        firebaseAuthDataSource.userLogin(email: email, password: password, completion: completion)
        
    }
    
    func userLogOut() throws {
        try firebaseAuthDataSource.userLogOut()
    }
}
