//
//  UseCases.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

extension SplashUseCase {
    static func build() -> SplashUseCase {
        return SplashUseCase(authService: Constants.isMock ? AuthenticationServiceMock() : AuthenticationService(firebaseAuthentication: FirebaseAuthentication.build() ))
    }
}

extension AuthenticationUseCase {
    static func build() -> AuthenticationUseCase {
        return AuthenticationUseCase(authService: Constants.isMock ? AuthenticationServiceMock() : AuthenticationService(firebaseAuthentication:FirebaseAuthentication.build() ))
    }
}

extension ProfileUseCase {
    static func build() -> ProfileUseCase {
        return ProfileUseCase(authService: Constants.isMock ? AuthenticationServiceMock() : AuthenticationService(firebaseAuthentication:FirebaseAuthentication.build() ))
    }
}
