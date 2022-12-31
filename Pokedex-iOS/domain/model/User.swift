//
//  User.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation

struct User {
    let email: String
    
    static let empty: Self = .init(email: "")
}
