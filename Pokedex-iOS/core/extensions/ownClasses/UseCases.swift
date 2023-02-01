//
//  UseCases.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

extension SplashUseCase {
    static func build() -> SplashUseCase {
        return SplashUseCase(authService: Constants.isMock ? AuthenticationServiceMock() : AuthenticationService.build() )
    }
}

extension AuthenticationUseCase {
    static func build() -> AuthenticationUseCase {
        return AuthenticationUseCase(authService: Constants.isMock ? AuthenticationServiceMock() : AuthenticationService.build() )
    }
}

extension ProfileUseCase {
    static func build() -> ProfileUseCase {
        return ProfileUseCase(authService: Constants.isMock ? AuthenticationServiceMock() : AuthenticationService.build() )
    }
}

extension PokedexUseCase {
    static func build() -> PokedexUseCase {
        return PokedexUseCase(pokedexService: Constants.isMock ? PokedexServiceMock() : PokedexService.build() )
    }
}

extension HomeUseCase {
    static func build() -> HomeUseCase {
        return HomeUseCase(pokedexService: Constants.isMock ? PokedexServiceMock() : PokedexService.build() )
    }
}

extension PokemonUseCase {
    static func build() -> PokemonUseCase {
        return PokemonUseCase(pokemonService: Constants.isMock ? PokemonServiceMock() : PokemonService.build() )
    }
}

extension ExploreUseCase {
    static func build() -> ExploreUseCase {
        return ExploreUseCase(locationService: LocationService(), pokedexService: PokedexService.build())
    }
}
