//
//  ViewModels.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

extension SplashViewModel {
    static func build() -> SplashViewModel {
        return SplashViewModel(splashUseCase: Constants.isMock ? SplashUseCaseMock() : SplashUseCase(authService: AuthenticationService.build() ))
    }
}

extension ProfileViewModel {
    static func build() -> ProfileViewModel {
        return ProfileViewModel(profileUseCase: Constants.isMock ? ProfileUseCaseMock() : ProfileUseCase(authService: AuthenticationService.build() ))
    }
}

extension AuthenticationViewModel {
    static func build()-> AuthenticationViewModel {
        return AuthenticationViewModel(authenticationUseCase: Constants.isMock ? AuthenticationUseCaseMock() : AuthenticationUseCase(authService: AuthenticationService.build() ))
    }
}
