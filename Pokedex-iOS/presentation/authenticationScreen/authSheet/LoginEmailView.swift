//
//  LoginEmailView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 29/12/22.
//

import SwiftUI

struct LoginEmailView: View {
    @State var emailText = ""
    @State var passwordText = ""
    var body: some View {
        VStack {
            DismissView()
                .padding(.top, 8)
            Group {
                Text("Welcome to")
                    .padding(.top, 20)
                Text("Pokedex")
            }
            .padding(.horizontal, 8)
            .multilineTextAlignment(.center)
            .font(.largeTitle)
            .tint(.primary)
            
            Group {
                Text("Login again to access all Pokedex functions")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 2)
                    TextField("Email", text: $emailText)
                    TextField("Password", text: $passwordText)
                    
                    Button ("Login"){
                        
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .disabled(true)

            }
            .padding(.horizontal, 60)
            .textFieldStyle(.roundedBorder)
            Spacer()

        }
        .controlSize(.large)
    }
}

struct LoginEmailView_Previews: PreviewProvider {
    static var previews: some View {
        LoginEmailView()
    }
}
