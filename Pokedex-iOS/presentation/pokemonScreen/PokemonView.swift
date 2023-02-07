//
//  PokemonView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI
import CoreData

struct PokemonView: View {
    let pokemonId: Int
    
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \PokemonFavorite.name, ascending: true),
            NSSortDescriptor(keyPath: \PokemonFavorite.url, ascending: true)
        ],
        animation: .default)
    private var pokemons: FetchedResults<PokemonFavorite>
    
    @StateObject private var viewModel: PokemonViewModel = .build()
    @State private var evoName = ""
    @State private var isEvoClick = false
    @State private var evoNameOpacity = 0.1
    @State private var isFavorite: Bool = false
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
                        Button {
                            let addFavorite = PokemonFavorite(context: self.moc)
                            if !self.isFavorite {
                                addFavorite.name = viewModel.name
                                addFavorite.url = viewModel.pokemonUrl
                                addFavorite.id = UUID()
                            } else {
                                let favPokemon = pokemons.filter( { fav in
                                    guard let name = fav.name else { return false }
                                    return name == viewModel.name
                               })
                                guard let pokemonFav = favPokemon.first else { return }
                                self.moc.delete(pokemonFav)
                            }
                            self.isFavorite.toggle()
                            try! self.moc.save()
                        } label: {
                            if viewModel.name.count > 2 {
                                Image(systemName: "star.fill")
                                    .foregroundColor(self.isFavorite ? viewModel.color : .gray)
                            }
                            
                        }
                        

                    }
                    
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
        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(viewModel.pokemonUrl.getPokemonIdByUrl()).png")
        ) { image in
            image
                .resizable()
                .frame(width: 200, height: 200)
        } placeholder: {
            ProgressView()
        }
        .task {
            viewModel.checkIsFavorite(listFav: pokemons)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                self.isFavorite = viewModel.isFavorite
            }
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
