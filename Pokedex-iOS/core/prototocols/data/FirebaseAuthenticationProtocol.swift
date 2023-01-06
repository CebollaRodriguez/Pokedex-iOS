//
//  FirebaseAuthenticationProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthenticationProtocol : AnyObject {
    func getCurrentUser()-> UserModel?
    
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void)
    
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void)
    
    func loginWithFacebook(completion: @escaping(Result<UserModel, Error>)-> Void)
    
    func loginWithGoogle(completion: @escaping(Result<UserModel, Error>) -> Void)
            
    func userLogOut() throws
    
    func currentProvider() -> [LinkedAccountModel]
    
    func linkFacebook(completion: @escaping(Bool) -> Void)
    
    func linkGoogle(completion: @escaping(Bool) -> Void)
    
    func getCurrentCredential(completion: @escaping(AuthCredential?) -> Void)
    
    func linkEmailAndPassword(email: String, password: String, completion: @escaping(Bool) -> Void)
    func deleteAccount(completion: @escaping(Result<Bool, Error>) -> Void) 
}
