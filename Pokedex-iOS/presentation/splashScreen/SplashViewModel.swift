//
//  SplashViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

final class SplashViewModel: ObservableObject {
    private let useCase: SplashUseCaseProtocol
    
    init(splashUseCase: SplashUseCaseProtocol) {
        self.useCase = splashUseCase
    }
    
    func getCurrentSession(completion: @escaping(User?) -> Void) {
        guard let user = useCase.getCurrentSession() else {
            UserDefaults.standard.set("", forKey: "EMAIL_KEY")
            completion(nil)
            return
        }
        UserDefaults.standard.set(user.email, forKey: "EMAIL_KEY")
        completion(user) 
    }
}

