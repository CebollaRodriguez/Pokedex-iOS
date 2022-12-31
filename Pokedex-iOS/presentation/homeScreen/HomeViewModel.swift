//
//  HomeViewModel.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let userLogOutUseCase: UserLogOutUseCase

    init(userLogOutUseCase: UserLogOutUseCase){
        self.userLogOutUseCase = userLogOutUseCase
    }
    
    
    func userLogOut() {
        do {
            try userLogOutUseCase.userLogOut()
            
        } catch {
            print("Error logout")
        }
    }
}

extension HomeViewModel {
    static func build() -> HomeViewModel{
        return HomeViewModel(userLogOutUseCase: UserLogOutUseCase())
    }
}
