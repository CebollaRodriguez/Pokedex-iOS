//
//  ProfileViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var linkedAccounts: [LinkedAccount] = []
    @Published var showAlert: Bool = false
    @Published var isAccountLinked: Bool = false
    private let useCase: ProfileUseCase
    
    init(profileUseCase: ProfileUseCase) {
        self.useCase = profileUseCase
    }
    
    func userLogOut() {
        do {
            try useCase.userLogOut()
        } catch {
            print("Error logout")
        }
    }
    
    func getCurrentProvider() {
        self.linkedAccounts = useCase.getCurrentProvider()
    }
    
    func isEmailAndPasswordLinked() -> Bool {
        self.linkedAccounts.contains(where: { $0.rawValue == "password" })
    }
    
    func isFacebookLinked() -> Bool {
        self.linkedAccounts.contains(where: { $0.rawValue == "facebook.com" })
    }
    
    func userLinkFacebook() {
        useCase.userLinkFacebook { [weak self] isSucces in
            self?.isAccountLinked = isSucces
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
    
    func userLinkEmailAndPassword(email: String, password: String) {
        useCase.userLinkEmailAndPassword(email: email, password: password) { [weak self] isSucces in
            self?.isAccountLinked = isSucces
            self?.showAlert.toggle()
            self?.getCurrentProvider()
        }
    }
}

extension ProfileViewModel {
    static func build() -> ProfileViewModel {
        return ProfileViewModel(profileUseCase: ProfileUseCase())
    }
}
