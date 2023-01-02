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
    private let useCase: AuthenticationUseCase
    
    init(
        userLoginUseCase: AuthenticationUseCase = AuthenticationUseCase()
    ) {
        self.useCase = userLoginUseCase
    }
    
    func getCurrentUser() {
        if let userModel = useCase.getCurrentUser(){
            self.user = .init(email: userModel.email)
        }
        
    }
    
    func createNewUser(email: String, password: String) {
        useCase.createNewUser(email: email, password: password) { [weak self]result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func emailLogin(email: String, password: String) {
        useCase.userLogin(email: email, password: password) { [weak self]result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func facebookLogin(){
        useCase.loginFacebook { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
}

//extension AuthenticationViewModel {
//    static func build()-> AuthenticationViewModel {
//        return AuthenticationViewModel(createNewUserUseCase: CreateNewUserUseCase(), getCurrentUserUseCase: GetCurrentUserUseCase(), userLoginUseCase: UserLoginUseCase()
//        )
//    }
//}
