//
//  AuthenticationView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 29/12/22.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var authSheetView: AuthenticationSheetView?
    @StateObject var viewModel: AuthenticationViewModel = .build()
    
    var body: some View {
        VStack {
            topImage
            logInButtons
            Spacer()
            registerButton
        }
        .sheet(item: $authSheetView) { sheet in
            switch sheet {
            case .register :
                RegisterEmailView(viewModel: viewModel)
            case .login:
                LoginEmailView(viewModel: viewModel)
            }
            
        }
        
    }
    
    var registerButton: some View {
        HStack{
            Text("Without account?")
            Button {
                authSheetView = .register
            } label: {
                Text("Register")
                    .underline()
            }
        }
    }
    
    var logInButtons: some View {
        VStack(spacing: 15) {
            Text("Login with:")
            Button {
                authSheetView = .login
            } label: {
                HStack {
                    Spacer()
                    Label("Email", systemImage: "envelope.fill")
                    Spacer()
                }
                
            }
            .tint(.black)
            Button {
                viewModel.facebookLogin{ email in
                    sessionManager.localLogIn(email: email)
                }
            } label: {
                HStack {
                    Spacer()
                    Image("facebook_ic")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Facebook")
                    Spacer()
                }
                
            }
            .tint(.blue)
            Button {
                viewModel.googleLogin { email in
                    sessionManager.localLogIn(email: email)
                }
            } label: {
                HStack {
                    Spacer()
                    Image("google_logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Google")
                    Spacer()
                }
                
            }
            .tint(.red)
            
        }
        .frame(width: 200)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .padding(.top, 30)
    }
    
    var topImage: some View {
        Image("splash_ic")
            .resizable()
            .frame(width: 150, height: 150)
            .shadow(radius: 4)
            .padding(.top, 30)
    }
    
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView( viewModel: .build())
    }
}
