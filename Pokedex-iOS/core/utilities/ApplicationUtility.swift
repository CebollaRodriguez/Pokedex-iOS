//
//  ApplicationUtility.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 03/01/23.
//

import SwiftUI

final class ApplicationUtility {
    
    static var rootViewControler: UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene  else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
