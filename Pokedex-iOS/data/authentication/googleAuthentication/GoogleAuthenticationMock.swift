//
//  GoogleAuthenticationMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class GoogleAuthenticationMock: GoogleAuthenticationProtocol {
    func googleLogin(completion: @escaping (Result<[String]?, Error>) -> Void) {
        completion(.success(["idToken Test", "accessToken Test"]))
    }
    
    func getTokens(completion: @escaping ([String]?) -> Void) {
        completion(["idToken Test", "accessToken Test"])
    }
    
    
}
