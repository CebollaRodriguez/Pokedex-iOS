//
//  ProfileUseCaseMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class ProfileUseCaseMock: ProfileUseCaseProtocol {
    func getCurrentProvider() -> [LinkedAccount] {
        [.emailAndPaswword]
    }
    
    func userLogOut() throws {
        print("ProfileUseCaseMock -USER LOGOUT-")
    }
    
    func userLinkFacebook(completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func userLinkGoogle(completion: @escaping (Bool) -> Void) {
        completion(false)
    }
    
    func userLinkEmailAndPassword(email: String, password: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func deleteAccount(completion: @escaping (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }
    
    
}
