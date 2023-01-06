//
//  ProfileUseCaseProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol ProfileUseCaseProtocol: AnyObject {
    
    func getCurrentProvider() -> [LinkedAccount]
    
    func userLogOut() throws
    
    func userLinkFacebook(completion: @escaping(Bool) -> Void)
    
    func userLinkGoogle(completion: @escaping(Bool) -> Void)
    
    func userLinkEmailAndPassword(email: String, password: String, completion: @escaping(Bool) -> Void)
    
    func deleteAccount(completion: @escaping(Result<Bool, Error>) -> Void) 
}
