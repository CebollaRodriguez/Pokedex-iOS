//
//  FacebookAuthenticationMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class FacebookAuthenticationMock: FacebookAuthenticationProtocol {
    func loginFacebook(completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success("emailTest@testing.com"))
    }
    
    func getAccesToken() -> String? {
        "access token test successful"
    }
    
}
