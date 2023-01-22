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
                homeBody
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                
                
            }
            .toolbar {
                NavigationLink {
                    ProfileView()
                } label: {
                    Image(systemName: "person.fill")
                        
                }

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var homeBody: some View {
        VStack {
            Text("Welcome \(email)")
                .padding(.top, 20)
            pokedexesList
        }
        .onAppear{
            homeViewModel.getPokedexeslist()
        }
    }
    
    var pokedexesList: some View {
        
        VStack {
            Text("Choose a pokedex")
                .foregroundColor(.secondary)
                .font(.title)
                .padding(.top, 3)
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 100)),
                    GridItem(.adaptive(minimum: 100)),
                ]) {
                    ForEach(homeViewModel.pokedexes, id: \.name) { pokedex in
                        var pokedexName = pokedex.name
                        NavigationLink {
                            PokedexView(pokedexUrl: pokedex.url)
                        } label: {
                            HStack{
                                Spacer()
                                Text(pokedexName.firstUpper())
                                
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
