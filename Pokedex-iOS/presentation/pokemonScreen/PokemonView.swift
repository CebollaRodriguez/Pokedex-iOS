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
    @State private var isViewVisible: Bool = false
    // Offsets
    @State private var offset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    @State private var nameOffSet: CGFloat = 0
    @State private var nameBarHeight: CGFloat = 0
    
    var body: some View {
        NavigationView {
            if isViewVisible {
                
                
                ZStack(alignment: .top) {
                    toolbarScreen
                        .zIndex(1)
                        .overlay (
                            GeometryReader { reader -> Color in
                                
                                let height = reader.frame(in: .global).maxY
                                
                                DispatchQueue.main.async {
                                    nameBarHeight = height - (UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
                                    
                                }
                                
                                return Color.clear
                            }
                                
                        )
                    ScrollView(showsIndicators: false) {
                        VStack {
                            pokemonImage
                            Rectangle()
                                .foregroundColor(viewModel.color)
                                .frame(width: 200, height: 400)
                            Text("\(viewModel.name) Evolves")
                                .foregroundColor(.secondary)
                                .font(.title)
                                .padding(.vertical)
                            pokemonEvolutions
                            Spacer()
                        }
                        .padding(.top, 10)
                        .padding(.top, nameBarHeight)
                        
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
                    
                    if offset >= 70 {
                        floatFavoriteButton
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
                
            } else {
                ScrollView {
                    contentPlaceHolder
                }
                .onAppear{
                    viewModel.getPokemon(id: pokemonId)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        withAnimation(.easeInOut(duration: 2.0)) {
                            if viewModel.name != "" {
                                self.isViewVisible = true
                            }
                        }
                    }
                }
            }
            
        }
        
        
    }
    var contentPlaceHolder: some View {
        VStack {
            HStack {
                RectanglePlaceHolder(width: 200, height: 50)
                    .padding(.leading, 20)
                Spacer()
            }
            .padding(.top,30)
            
            RectanglePlaceHolder(width: 300, height: 300)
                .padding(.top, 10)
            HStack {
                RectanglePlaceHolder(width: 150, height: 60)
                RectanglePlaceHolder(width: 150, height: 60)

            }
            .padding(.top)
            HStack {
                RectanglePlaceHolder(width: 150, height: 60)
                RectanglePlaceHolder(width: 150, height: 60)

            }
            .padding(.top)
            HStack {
                RectanglePlaceHolder(width: 150, height: 60)
                RectanglePlaceHolder(width: 150, height: 60)

            }
            .padding(.top)
            
            HStack {
                RectanglePlaceHolder(width: 150, height: 150)
                RectanglePlaceHolder(width: 150, height: 150)
                RectanglePlaceHolder(width: 150, height: 150)

            }
            .padding(.top, 10)
        }
    }
    var floatFavoriteButton: some View {
        VStack {
            Spacer()
            HStack{
                Spacer()
                Circle()
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .frame(width: 80, height: 80)
                    .overlay(alignment: .center) {
                        favoriteButton
                    }
                    .padding(.trailing, 20)
            }
            .opacity(offset < 125 ? (offset < 95 ? 0.4 : 0.7) : 1)
        }
        
    }
    
    var favoriteButton: some View {
        Button {
            
            // Saving or Deleting the current pokemon into db
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
                    .font(.system(size: 25, weight: .semibold))
                
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
                favoriteButton
                .padding(.trailing, 20)
                .opacity(offset > 35 ? (offset > 50 ? 0 : 0.7) : 1)
                .disabled(offset > 65)
            }
            
            HStack {
                
                Text(viewModel.name)
                    .font(.largeTitle)
                    
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
            .padding(20)
            // getting offset and moving the view
            .offset(getOffset())
            
            

            
        }
        .padding(.bottom, getOffset().height)
        .padding(.top, 20)
        .background(offset > 65 ? viewModel.color?.ignoresSafeArea() : .none)
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
                .background(.secondary)
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
        
        size.width = offset > 0 ? (offset * 1.5 <= (screenWidth - nameOffSet ) ? offset * 1.5 : ( screenWidth - nameOffSet)) : 0
        size.height = offset > 0 ? (offset <= 65 ? -offset : -65) : 0
        return size
    }
}


struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemonId: 1)
    }
}
