//
//  HomeView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import SwiftUI

struct HomeView: View {
    let email: String
    @StateObject var authViewModel: AuthenticationViewModel
    @StateObject private var homeViewModel: HomeViewModel = .build()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome \(email)")
                    .padding(.top, 20)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            .toolbar {
                Button("Logout") {
                    self.homeViewModel.userLogOut()
                    self.authViewModel.user = nil
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(email: "gabrielsanchezperaza@gmail.com", authViewModel: .build())
    }
}
