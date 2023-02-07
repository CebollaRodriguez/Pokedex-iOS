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
            NSSortDescriptor(keyPath: \PokemonFavorite.url, ascending: true)
        ],
        animation: .default)
    private var pokemons: FetchedResults<PokemonFavorite>
    @State private var isEmpty: Bool = true
    
    var body: some View {
        
        NavigationView {
            VStack {
                if !isEmpty {
                    pokemonGrid
                } else {
                    ProgressView()
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                if !self.pokemons.isEmpty {
                                    self.isEmpty = false
                                }
                            }
                        }
                }
            }
            
            
        }
        
    }
    
    var pokemonGrid: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100)),
                GridItem(.adaptive(minimum: 100))
            ]) {
                ForEach(pokemons, id: \.id) { pokemon in
                    if pokemon.url?.count ?? 0 > 2 {
                        var pokemonUrl = pokemon.url!
                        var pokemonName: String = pokemon.name!
                        
                        NavigationLink{
                            PokemonView(pokemonId: Int(pokemonUrl.getPokemonIdByUrl())!)
                                .environment(\.managedObjectContext, self.moc)
                        } label: {
                            HStack {
                                Spacer()
                                VStack {
                                    
                                    Text(pokemonName)
                                        .foregroundColor(.primary)
                                        .font(.caption)
                                }
                                Spacer()
                            }
                            
                            .frame(height: 150)
                            .background(.red)
                            .cornerRadius(10)
                            
                        }
                        .padding(2)
                    }
                    
                }
            }
            .padding(.horizontal,20)
            
        }

    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
