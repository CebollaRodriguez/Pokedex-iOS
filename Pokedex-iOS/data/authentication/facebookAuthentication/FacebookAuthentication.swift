//
//  FacebookAuthentication.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation
import FacebookLogin

final class FacebookAuthentication {
    let loginManager = LoginManager()
    
    func loginFacebook(completion: @escaping(Result<String, Error>) ->Void) {
        loginManager.logIn(permissions: ["email"], from: nil){ result, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            let token = result?.token?.tokenString
            completion(.success(token ?? "Empty Token"))
        }
    }
    
    func 
}
