//
//  FirebaseAuthDataSource.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthDataSource {
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
}
