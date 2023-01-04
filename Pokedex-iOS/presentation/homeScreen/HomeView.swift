//
//  HomeView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import SwiftUI

struct HomeView: View {
    let email: String
    @StateObject private var homeViewModel: HomeViewModel = .build()
    
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    Text("Welcome \(email)")
                        .padding(.top, 20)
                    
                    pokedexesList
                }
                .onAppear{
                    homeViewModel.getPokedexeslist()
                }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.fill")
                        
                    }
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var pokedexesList: some View {
        
        VStack {
            Text("Choose a pokedex")
                .foregroundColor(.secondary)
                .font(.title)
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 100)),
                    GridItem(.adaptive(minimum: 100)),
                ]) {
                    ForEach(homeViewModel.pokedexes, id: \.name) { pokedex in
                        NavigationLink {
                            PokedexView(pokedexUrl: pokedex.url)
                        } label: {
                            HStack{
                                Spacer()
                                Text(pokedex.name)
                                
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .frame(height: 80)

                        }
                        
                        .buttonStyle(.borderless)
                        .background()
                        .padding(3)
                        .shadow(radius: 5)

                    }
                }

            }
            .padding(.bottom)
        }
        .padding(.horizontal, 30)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(email: "gabrielsanchezperaza@gmail.com")
    }
}
