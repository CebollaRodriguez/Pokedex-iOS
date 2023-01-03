//
//  GoogleAuthentication.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 03/01/23.
//

import Foundation
import Firebase
import GoogleSignIn

class GoogleAuthentication {
    func googleLogin(completion: @escaping(Result<GIDGoogleUser, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: ApplicationUtility.rootViewControler) {  signInResult, error in
            
            if let error = error {
                print("Error Google SignIn: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let user = signInResult?.user else { return }
            completion(.success(user))
            
        }
    }
}
