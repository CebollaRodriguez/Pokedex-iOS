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
    private let sessionManager = SessionManager()
    
    init(authenticationUseCase: AuthenticationUseCase) {
        self.useCase = authenticationUseCase
    }
    
    func getCurrentUser(completion: @escaping () -> Void) {
        if let userModel = useCase.getCurrentUser(){
            self.user = .init(email: userModel.email)
        }
        completion()
    }
    
    func createNewUser(email: String, password: String, completion: @escaping()-> Void) {
        useCase.createNewUser(email: email, password: password) { [weak self]result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
                completion()
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func emailLogin(email: String, password: String, completion:@escaping()-> Void) {
        useCase.userLogin(email: email, password: password) { [weak self]result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
                completion()
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func facebookLogin(completion: @escaping(String)-> Void){
        useCase.loginFacebook { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = .init(email: user.email)
                completion(user.email)
            case .failure(let error):
                self?.messageError = error.localizedDescription
            }
        }
    }
    
    func googleLogin(completion: @escaping(String) -> Void) {
        useCase.loginGoogle { [self] result in
            switch result {
            case .success(let user):
                self.user = .init(email: user.email)
                completion(user.email)
            case .failure(let error):
                self.messageError = error.localizedDescription
            }
        }
    }
}

extension AuthenticationViewModel {
    static func build()-> AuthenticationViewModel {
        return AuthenticationViewModel(authenticationUseCase: AuthenticationUseCase())
    }
}
