//
//  FirebaseAuthentication.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 30/12/22.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthentication: FirebaseAuthenticationProtocol {
    private let facebookAuth: FacebookAuthenticationProtocol
    private let googleAuth: GoogleAuthenticationProtocol
    
    init(facebookAuth: FacebookAuthenticationProtocol, googleAuth: GoogleAuthenticationProtocol) {
        self.facebookAuth = facebookAuth
        self.googleAuth = googleAuth
    }
    
    func getCurrentUser()-> UserModel?{
        guard let email = Auth.auth().currentUser?.email else { return nil }
        return .init(email: email)
    }
    
    func createNewUser(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {result, error in
            if let error = error{
                print("Error creating a new user \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            let email = result?.user.email ?? ""
            print("New user created: \(email)")
            completion(.success(.init(email: email)))
            
        }
    }
    
    func userLogin(email: String, password: String, completion: @escaping(Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {result, error in
            if let error = error{
                print("Error login user \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            let email = result?.user.email ?? ""
            print("User login: \(email)")
            completion(.success(.init(email: email)))
            
        }
    }
    
    func loginWithFacebook(completion: @escaping(Result<UserModel, Error>)-> Void) {
        facebookAuth.loginFacebook { result in
            switch result {
            case .success(let accesToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: accesToken)
                Auth.auth().signIn(with: credential) { dataResult, error in
                    if let error = error {
                        print("LOIGIN WITH FACEBOOK, FIREBASEAUTH: \(error.localizedDescription)")
                        completion(.failure(error))
                        return
                    }
                    let userEmail = dataResult?.user.email ?? "No Email"
                    completion(.success(.init(email: userEmail)))
                }
            case .failure(let error):
                print("Error sigIn with facebook \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func loginWithGoogle(completion: @escaping(Result<UserModel, Error>) -> Void) {
        googleAuth.googleLogin { result in
            switch result {
            case.success(let tokens):
                guard let idToken = tokens?.first else { return }
                guard let accesToken = tokens?.last else { return }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accesToken)
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        print("LOIGIN WITH Google, FIREBASEAUTH: \(error.localizedDescription)")
                        completion(.failure(error))
                        return
                    }
                    let userEmail = result?.user.email ?? "No email"
                    completion(.success(.init(email: userEmail)))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func userLogOut() throws {
        try Auth.auth().signOut()
    }
    
    func currentProvider() -> [LinkedAccountModel] {
        guard let currentUser = Auth.auth().currentUser else {
            return []
        }
        
        let linkedAccounts = currentUser.providerData.map { userInfo in
            LinkedAccountModel(rawValue: userInfo.providerID)
        }.compactMap{ $0 }
        
        return linkedAccounts
    }
    
    func linkFacebook(completion: @escaping(Bool) -> Void) {
        facebookAuth.loginFacebook { result in
            switch result {
            case .success(let token):
                let credential = FacebookAuthProvider.credential(withAccessToken: token)
                Auth.auth().currentUser?.link(with: credential, completion: { authData, error in
                    if let error = error {
                        print("Error link facebook: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    _ = authData?.user.email ?? "No Email"
                    completion(true)
                    
                })
            case .failure(let error):
                print("Error linking a new user \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func linkGoogle(completion: @escaping(Bool) -> Void) {
        googleAuth.googleLogin { result in
            switch result {
            case.success(let tokens):
                guard let idToken = tokens?.first else { return }
                guard let accesToken = tokens?.last else { return }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accesToken)
                Auth.auth().signIn(with: credential) { result, error in
                    if let error = error {
                        print("LOIGIN WITH Google, FIREBASEAUTH: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    completion(true)
                }
                
            case .failure(let error):
                print("Error linking a new user \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func getCurrentCredential(completion: @escaping(AuthCredential?) -> Void) {
        guard let providerId = currentProvider().last else{
            return
        }
        
        switch providerId {
        case .facebook:
            guard let accessToken = facebookAuth.getAccesToken() else {
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            completion(credential)
        case .google:
            googleAuth.getTokens() { accTokens in
                if let tokens = accTokens {
                    guard
                        let idToken = tokens.first,
                        let accesToken = tokens.last
                    else {
                        return
                    }
                    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accesToken)
                     completion(credential)
                } else {
                    return
                }
            }
            return
        case .emailAndPaswword, .unknown:
            return
        }
    }
    
    func linkEmailAndPassword(email: String, password: String, completion: @escaping(Bool) -> Void) {
        
        getCurrentCredential { authCred in
            if let credential = authCred {
                Auth.auth().currentUser?.reauthenticate(with: credential, completion: { authData, error in
                    if let error = error {
                        print("Error linking email \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    
                    let emailAndPasswordCredential = EmailAuthProvider.credential(withEmail: email, password: password)
                    
                    Auth.auth().currentUser?.link(with: emailAndPasswordCredential, completion: { authDataResult, error in
                        if let error = error {
                            print("Error linking email \(error.localizedDescription)")
                            completion(false)
                            return
                        }
                        completion(true)
                    })
                })
            }
            
        }
    }
    
    func deleteAccount(completion: @escaping(Result<Bool, Error>) -> Void) {
        Auth.auth().currentUser?.delete{ error in
            if let error = error {
                completion(.failure(error))
                
            } else {
                completion(.success(true))
            }
            
        }
    }
}
