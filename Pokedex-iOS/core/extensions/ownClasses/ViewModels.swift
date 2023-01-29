//
//  ViewModels.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

extension SplashViewModel {
    static func build() -> SplashViewModel {
        return SplashViewModel(splashUseCase: Constants.isMock ? SplashUseCaseMock() : SplashUseCase.build())
    }
}

extension ProfileViewModel {
    static func build() -> ProfileViewModel {
        return ProfileViewModel(profileUseCase: Constants.isMock ? ProfileUseCaseMock() : ProfileUseCase.build() )
    }
}

extension AuthenticationViewModel {
    static func build()-> AuthenticationViewModel {
        return AuthenticationViewModel(authenticationUseCase: Constants.isMock ? AuthenticationUseCaseMock() : AuthenticationUseCase.build() )
    }
}

extension PokedexViewModel {
    static func build() -> PokedexViewModel {
        return PokedexViewModel(useCase: Constants.isMock ? PokedexUseCaseMock() : PokedexUseCase.build() )
    }
}

extension HomeViewModel {
    static func build() -> HomeViewModel{
        return HomeViewModel(useCase: Constants.isMock ? HomeUseCaseMock() : HomeUseCase.build() )
    }
}

extension PokemonViewModel {
    static func build() -> PokemonViewModel {
        return PokemonViewModel(useCase: Constants.isMock ? PokemonUseCaseMock() : PokemonUseCase.build() )
    }
}

extension ExploreViewModel {
    static func build() -> ExploreViewModel {
        return ExploreViewModel(useCase: ExploreUseCase.build())
    }
}
