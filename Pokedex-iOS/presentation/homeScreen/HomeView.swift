//
//  HomeView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import SwiftUI

struct HomeView: View {
    let email: String
    @ObservedObject var authViewModel: AuthenticationViewModel
    @StateObject private var homeViewModel: HomeViewModel = .build()
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Text("Welcome \(email)")
                        .padding(.top, 20)
                    Spacer()
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                ProfileView(authViewModel: authViewModel)
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                        
                    }
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Home")
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(email: "gabrielsanchezperaza@gmail.com", authViewModel: AuthenticationViewModel())
    }
}
