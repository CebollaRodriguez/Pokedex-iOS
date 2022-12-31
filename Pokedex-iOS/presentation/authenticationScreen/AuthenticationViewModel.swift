//
//  AuthenticationViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation

final class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    private let createNewUserUseCase: CreateNewUserUseCase

    init(createNewUserUseCase: CreateNewUserUseCase = CreateNewUserUseCase()) {
        self.createNewUserUseCase = createNewUserUseCase
    }
    
    func createNewUser(email: String, password: String) {
        createNewUserUseCase.createNewUser(email: email, password: password) { [weak self]result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
            case .failure(let error):
                self? .messageError = error.localizedDescription
            }
        }
    }
}
