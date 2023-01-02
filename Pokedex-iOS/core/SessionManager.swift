//
//  SessionManager.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import Foundation

class SessionManager: ObservableObject {
    @Published var email: String? = UserDefaults.standard.string(forKey: "EMAIL_KEY")
    
    func localLogIn(email:String) {
        self.email = email
        UserDefaults.standard.set(email, forKey: "EMAIL_KEY")
    }
    
    func localLogOut() {
        self.email = ""
        UserDefaults.standard.set("", forKey: "EMAIL_KEY")
    }
}
