//
//  GoogleAuthenticationProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol GoogleAuthenticationProtocol: AnyObject {
    func googleLogin(completion: @escaping(Result<[String]?, Error>) -> Void)
    
    func getTokens(completion: @escaping([String]?) -> Void)
}
