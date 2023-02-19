//
//  PokedexView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI

struct PokedexView: View {
    @StateObject private var viewModel: PokedexViewModel = .build()
    @Environment(\.managedObjectContext) private var moc
    
    // Pokedex Properties
    @Binding var pokedex: Pokedexes
    @Binding var wasChanged: Bool
    @Binding var searchText: String
    // View propierties
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
        .onAppear {
            isContentVisible = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                if pokedex.name.count > 3 {
                    viewModel.getPokedex(url: pokedex.url)
                }
            }
        }
    }
    
    var pokemons: some View {

        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100))
            ]) {
                ForEach(searchText != "" ? viewModel.model.pokemons.filter{ pokemon in
                    pokemon.name.lowercased().contains(searchText.lowercased() )
                } : viewModel.model.pokemons, id: \.id) { pokemon in
                    var pokemonUrl: String = pokemon.url
                    var name = pokemon.name
                    
                    NavigationLink{
                        PokemonView(pokemonId: Int(pokemonUrl.getPokemonIdByUrl())!)
                            .environment(\.managedObjectContext, self.moc)
                    } label: {
                        HStack {
                            Spacer()
                            VStack {
                                PokemonImage(id: pokemonUrl.getPokemonIdByUrl(), width: 80, height: 90)
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                
                withAnimation(.easeInOut(duration: 2.0)) {
                    self.isContentVisible = true
                }
            }
        }
    }
    
   
}




