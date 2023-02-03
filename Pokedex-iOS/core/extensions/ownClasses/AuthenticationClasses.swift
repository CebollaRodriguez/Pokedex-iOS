//
//  AuthenticationClasses.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

extension FirebaseAuthentication {
    static func build() -> FirebaseAuthentication {
        return FirebaseAuthentication(facebookAuth: Constants.isMock ? FacebookAuthenticationMock() : FacebookAuthentication(), googleAuth: Constants.isMock ? GoogleAuthenticationMock() : GoogleAuthentication())
    }
}

extension AuthenticationService {
    static func build() -> AuthenticationService {
        return AuthenticationService(firebaseAuthentication: Constants.isMock ? FirebaseAuthenticationMock() : FirebaseAuthentication.build() )
    }
}


