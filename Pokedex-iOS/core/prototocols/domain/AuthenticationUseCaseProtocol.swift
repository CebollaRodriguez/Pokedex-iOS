//
//  AuthenticationUseCaseProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol AuthenticationUseCaseProtocol: AnyObject {
    func getCurrentUser()-> UserModel?
    
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void)
    
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void)
    
    func loginFacebook(completion: @escaping(Result<UserModel, Error>) -> Void)
    
    func loginGoogle(completion: @escaping(Result<UserModel, Error>) -> Void) 
}
