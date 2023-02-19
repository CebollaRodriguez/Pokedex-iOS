//
//  FavoriteView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 01/02/23.
//

import SwiftUI
import CoreData

struct FavoriteView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \PokemonFavorite.name, ascending: true),
            NSSortDescriptor(keyPath: \PokemonFavorite.pokemonId, ascending: true)
        ],
        animation: .default)
    private var pokemons: FetchedResults<PokemonFavorite>
    @State private var isNotEmpty: Bool = true
    
    var body: some View {
        
        
        
        if isNotEmpty {
            VStack {
                title
                          
                pokemonGrid
            }
            
        } else {
            ProgressView()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if !self.pokemons.isEmpty {
                            self.isNotEmpty = true
                        }
                    }
                }
        }
    }
    
    
    
    
    
    var title: some View {
        VStack {
            
            HStack {
                Text ("My ")
                    .font(.largeTitle)
                    .foregroundColor(.primary)
                +
                
                Text("Pokemons")
                    .font(.largeTitle)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            
           
            HStack{
                Text("Favorites")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Rectangle()
                    .foregroundColor(.secondary)
                    .frame(height: 0.5)
            }
            .padding(.top,10)
            
            
        }
        .padding(.horizontal, 20)

    }
    
    var pokemonGrid: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100))
            ]) {
                ForEach(pokemons, id: \.uuid) { pokemon in
                    if pokemon.pokemonId > 0 {
                        
                        var pokemonName: String = pokemon.name!
                        
                        NavigationLink{
                            PokemonView(pokemonId: Int(pokemon.pokemonId))
                                .environment(\.managedObjectContext, self.moc)
                        } label: {
                            HStack {
                                Spacer()
                                VStack {
                                    PokemonImage(id: String(pokemon.pokemonId), width: 80, height: 90)
                                    Text(pokemonName.firstUpper())
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
            }
            .padding(.top, 10)
            
            .padding(.horizontal,20)
            
        }
        
        
    }
    
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
