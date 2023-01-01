//
//  FirebaseAuthentication.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthentication {
    private let facebookAuth = FacebookAuthentication()
    
    func getCurrentUser()-> UserModel?{
        guard let email = Auth.auth().currentUser?.email else { return nil }
        return .init(email: email)
    }
    
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error{
                print("Error creating a new user \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            let email = result?.user.email ?? ""
            print("New user created: \(email)")
            completion(.success(.init(email: email)))
            
        }
    }
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error{
                print("Error login user \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            let email = result?.user.email ?? ""
            print("User login: \(email)")
            completion(.success(.init(email: email)))
            
        }
    }
    
    func loginWithFacebook(completion: @escaping(Result<UserModel, Error>)-> Void) {
        facebookAuth.loginFacebook { result in
            switch result {
            case .success(let accesToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accesToken)
                Auth.auth().signIn(with: credential) { dataResult, error in
                    if let error = error {
                        print(error.localizedDescription)
                        completion(.failure(error))
                        return
                    }
                    let userEmail = dataResult?.user.email ?? "No Email"
                    completion(.success(.init(email: userEmail)))
                }
            case .failure(let error):
                print("Error sigIn with facebook \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func userLogOut() throws {
        try Auth.auth().signOut()
    }
}
