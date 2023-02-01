//
//  PokemonView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI

struct PokemonView: View {
    let pokemonId: Int
    @StateObject private var viewModel: PokemonViewModel = .build()
    @State private var evoName = ""
    @State private var isEvoClick = false
    @State private var evoNameOpacity = 0.1
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    pokemonImage
                    pokemonEvolutions
                }
                if isEvoClick {
                    VStack {
                        Spacer()
                        evoNameToast
                    }
                    .opacity(evoNameOpacity)
                    .onAppear {
                        withAnimation (.easeIn(duration: 1.0)) {
                            self.evoNameOpacity = 0.2
                        }
                    }
                }
            }
            .task{
                viewModel.getPokemon(id: pokemonId)
            }
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    HStack {
                        Spacer()
                        Text(viewModel.name)
                            .font(.largeTitle)
                        Spacer()
                    }
                    .background(viewModel.color)
                }
                
            }
        }
        
        
    }
    var pokemonEvolutions: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.pokemonEvolution, id: \.evoName) { evolution in
                    
                    AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(evolution.evoId).png")
                    ) { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                            .onTapGesture {
                                self.evoName = evolution.evoName
                                self.isEvoClick = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    self.isEvoClick = false
                                }
                            }
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
    
    var pokemonImage: some View {
        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonId).png")
        ) { image in
            image
                .resizable()
                .frame(width: 200, height: 200)
        } placeholder: {
            ProgressView()
        }
        
    }
    
    var evoNameToast: some View {
        ZStack {
            Rectangle()
                .background(.gray)
                .frame(width: .infinity, height: 30)
                .opacity(0.2)
                .cornerRadius(20)
                .padding(40)
                

            Text(evoName)
                .frame(width: .infinity, height: 30)
                .foregroundColor(.white)
                .font(.headline.bold())
                
        }
    }
    
}


struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemonId: 1)
    }
}
