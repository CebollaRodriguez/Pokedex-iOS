//
//  HomeView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 31/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel: HomeViewModel = .build()
    @Environment(\.managedObjectContext) private var moc
    
    
    var body: some View {
        VStack {
            DropDown(
                content: $homeViewModel.pokedexesName,
                selection: $homeViewModel.selection,
                activeTint: .primary.opacity(0.1),
                inActiveTint: .black.opacity(0.05)
            )
            .frame(width: 180)
            
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
                                .environment(\.managedObjectContext, self.moc)
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
        HomeView()
    }
}
