//
//  PokemonView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI
import CoreData

struct PokemonView: View {
    // Pokemon Properties
    let pokemonId: Int
    
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \PokemonFavorite.name, ascending: true),
            NSSortDescriptor(keyPath: \PokemonFavorite.pokemonId, ascending: true)
        ],
        animation: .default)
    private var pokemons: FetchedResults<PokemonFavorite>
    
    // View proporties
    @StateObject private var viewModel: PokemonViewModel = .build()
    @State private var evoName = ""
    @State private var isEvoClick = false
    @State private var evoNameOpacity = 0.1
    @State private var isFavorite: Bool = false
    @State private var isFavoriteClick: Bool = false
    // Offsets
    @State private var offset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var nameOffSet: CGFloat = 0
    
    var body: some View {
        NavigationView {
            VStack {
                toolbarScreen
                ZStack {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            pokemonImage
                            Rectangle()
                                .foregroundColor(viewModel.color)
                                .frame(width: 200, height: 400)
                            pokemonEvolutions
                            Spacer()
                        }
                        
                        // Getting offset
                        .overlay(
                            GeometryReader { proxy -> Color in
                                
                                let minY = proxy.frame(in: .global).minY
                                
                                DispatchQueue.main.async {
                                    if startOffset == 0 {
                                        startOffset = minY
                                    }
                                    offset = startOffset - minY
                                    
                                }
                                
                                return Color.clear
                            }
                                .frame(width: 0, height: 0)
                            , alignment: .top
                        )
                    }
                    
                    if isEvoClick {
                        VStack {
                            Spacer()
                            evoNameToast
                        }
                    }
                    
                    if isFavoriteClick {
                        favoriteStateToast
                    }
                }
                .task{
                    viewModel.getPokemon(id: pokemonId)
                }
            }
            
        }
        
        
    }
    
    var favoriteStateToast: some View {
        VStack {
            Spacer()
            Rectangle()
                .background(.gray)
                .frame(width: 200, height: 30)
                .opacity(0.2)
                .cornerRadius(20)
                .padding(40)
                .overlay {
                    Text(isFavorite ? "Saving in favorites" : "Deleting of favorites")
                        .frame( height: 30)
                        .foregroundColor(.white)
                        .font(.headline.bold())
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isFavoriteClick = false
            }
        }
    }
    
    var toolbarScreen: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    if !self.isFavorite {
                        let addFavorite = PokemonFavorite(context: self.moc)
                        addFavorite.name = viewModel.name
                        addFavorite.pokemonId = Int32(viewModel.id)
                        addFavorite.uuid = UUID()
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
                    self.isFavoriteClick.toggle()
                    
                } label: {
                    if viewModel.name != "" {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .foregroundColor(self.isFavorite ? viewModel.color : .gray)
                            .padding(.trailing, 20)
                            .font(.system(size: 25, weight: .semibold))
                        
                    }
                }
            }
            
            HStack {
                Spacer()
                Text(viewModel.name)
                    .font(.largeTitle)
                    .padding(.leading,10)
                Spacer()
                
            }
            .overlay(
                GeometryReader { reader -> Color in
                    let width = reader.frame(in: .global).maxX
                    
                    DispatchQueue.main.async {
                        if nameOffSet == 0 {
                            nameOffSet = width
                        }
                    }
                    
                    return Color.clear
                }
                    .frame(width: 0, height: 0)
            )
            .padding()
            // getting offset and moving the view
            .offset(getOffset())
            
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
                            .onDisappear{
                                self.startOffset = 0
                            }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    var pokemonImage: some View {
        PokemonImage(id: String(pokemonId), width: 300, height: 300)
            .task {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    viewModel.checkIsFavorite(listFav: pokemons)
                    self.isFavorite = viewModel.isFavorite
                }
            }
    }
    
    var evoNameToast: some View {
        HStack {
            
            Rectangle()
                .background(.gray)
                .frame(width: 200, height: 30)
                .opacity(0.2)
                .cornerRadius(20)
                .padding(40)
                .overlay {
                    Text(evoName)
                        .frame( height: 30)
                        .foregroundColor(.white)
                        .font(.headline.bold())
                }
            
        }
    }
    
    func getOffset ()->CGSize{
        var size: CGSize = .zero
        let screenWidth = UIScreen.main.bounds.width/1.3
        print(screenWidth)
        
        size.width = offset > 0 ? (offset * 1.5 <= (screenWidth - nameOffSet ) ? -offset * 1.5 : ( nameOffSet - screenWidth )) : 0
        size.height = offset > 0 ? (offset <= 60 ? -offset : -60) : 0
        return size
    }
}


struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemonId: 1)
    }
}
