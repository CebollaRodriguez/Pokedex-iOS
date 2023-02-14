//
//  PokedexView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI

struct PokedexView: View {
    @Binding var pokedex: Pokedexes
    @Binding var wasChanged: Bool
    @StateObject private var viewModel: PokedexViewModel = .build()
    @Environment(\.managedObjectContext) private var moc
    @State private var isContentVisible: Bool = false
    var body: some View {
        
        if wasChanged {
            pokedexViewContent
        } else {
            pokedexViewContent
        }
    }
    
    var pokedexViewContent : some View{
        VStack {
            
            if isContentVisible {
                pokemons
            } else {
                pokemons
                    .redacted(reason: .placeholder)
            }
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                if pokedex.name.count > 3 {
                    viewModel.getPokedex(url: pokedex.url)
                }
            }
        }
    }
    
    var pokemons: some View {

        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100))
            ]) {
                ForEach(viewModel.model.pokemons, id: \.id) { pokemon in
                    var pokemonUrl: String = pokemon.url
                    var name = pokemon.name
                    
                    NavigationLink{
                        PokemonView(pokemonId: Int(pokemonUrl.getPokemonIdByUrl())!)
                            .environment(\.managedObjectContext, self.moc)
                    } label: {
                        HStack {
                            Spacer()
                            VStack {
                                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonUrl.getPokemonIdByUrl()).png")
                                ) { image in
                                    image
                                        .resizable()
                                        .frame(width: 80, height: 90)
                                } placeholder: {
                                    if isContentVisible {
                                        ProgressView()
                                    } else {
                                        
                                    }
                                    
                                }
                                Text(name.firstUpper())
                                    .foregroundColor(.primary)
                                    .font(.caption)
                                
                            }
                            
                            
                            Spacer()
                        }
                        
                        .frame(height: 150)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                        
                    }
                    .padding(2)
                }
            }
            .padding(.horizontal,20)
            
        }
        .onAppear{
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                
                withAnimation(.easeInOut(duration: 1.5)) {
                    self.isContentVisible = true
                }
            }
        }
    }
}




