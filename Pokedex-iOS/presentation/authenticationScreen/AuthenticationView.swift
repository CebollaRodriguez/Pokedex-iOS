//
//  AuthenticationView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 29/12/22.
//

import SwiftUI

struct AuthenticationView: View {
    @State private var authSheetView: AuthenticationSheetView?
    @StateObject var viewModel: AuthenticationViewModel
    
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
            Text("Witout account?")
            Button {
                authSheetView = .register
            } label: {
                Text("Register")
                    .underline()
            }
        }
    }
    
    var logInButtons: some View {
        VStack {
            Text("Login with:")
            Button {
                authSheetView = .login
            } label: {
                Label("Email", systemImage: "envelope.fill")
                
            }
            .tint(.black)
            Button {
                viewModel.facebookLogin()
            } label: {
                HStack {
                    Image("facebook_ic")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Facebook")
                }
                
            }
            .tint(.blue)
            
        }
        .frame(width: 300)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .padding(.top, 50)
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
        AuthenticationView( viewModel: AuthenticationViewModel())
    }
}
