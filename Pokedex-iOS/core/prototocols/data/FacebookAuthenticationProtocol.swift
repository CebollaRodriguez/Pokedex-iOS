//
//  FacebookAuthenticationProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

protocol FacebookAuthenticationProtocol: AnyObject {
    func loginFacebook(completion: @escaping(Result<String, Error>) ->Void)
    
    func getAccesToken() -> String?

}
