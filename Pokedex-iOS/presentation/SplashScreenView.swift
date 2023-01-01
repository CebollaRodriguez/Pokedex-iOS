//
//  SplashScreenView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/12/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var isActive = true
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @State private var user: User?
    var body: some View {
        
        if isActive {
            VStack {
                VStack {
                    Image("splash_ic")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .padding()
                    Text("Pokedex")
                        .foregroundColor(.black)
                        .font(.title.bold())
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                authenticationViewModel.getCurrentUser { user in
                    self.user = user
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.isActive = false
                    }
                }
            }
        } else {
            if let user = self.user{
                HomeView(email: user.email, authViewModel: authenticationViewModel)
            } else{
                AuthenticationView(viewModel: authenticationViewModel)
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
