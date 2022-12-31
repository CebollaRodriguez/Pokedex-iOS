//
//  AuthenticationViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation

class AuthenticationViewModel: ObservableObject {
    @Published var user: User?
    @Published var messageError: String?
    private let createNewUserUseCase: CreateNewUserUseCase
    private let getCurrentUserUseCase: GetCurrentUserUseCase
    private let userLoginUseCase: UserLoginUseCase
    
    init(
        createNewUserUseCase: CreateNewUserUseCase,
        getCurrentUserUseCase: GetCurrentUserUseCase,
        userLoginUseCase: UserLoginUseCase
    ) {
        self.createNewUserUseCase = createNewUserUseCase
        self.getCurrentUserUseCase = getCurrentUserUseCase
        self.userLoginUseCase = userLoginUseCase
        //                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0){
        //self?.messageError = nil
        //}

        getCurrentUser()
    }
    
    func getCurrentUser() {
        if let userModel = getCurrentUserUseCase.getCurrentUser(){
            self.user? = .init(email: userModel.email)
        }
        
    }
    
    func createNewUser(email: String, password: String) {
        createNewUserUseCase.createNewUser(email: email, password: password) { [weak self]result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func userLogin(email: String, password: String) {
        userLoginUseCase.userLogin(email: email, password: password) { [weak self]result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}

extension AuthenticationViewModel {
    static func build()-> AuthenticationViewModel {
        return AuthenticationViewModel(createNewUserUseCase: CreateNewUserUseCase(), getCurrentUserUseCase: GetCurrentUserUseCase(), userLoginUseCase: UserLoginUseCase()
        )
    }
}
