//
//  SplashUseCaseMock.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation

class SplashUseCaseMock: SplashUseCaseProtocol {
    func getCurrentSession() -> User? {
        .init(email: "emailTest@emal.com")
    }
}
