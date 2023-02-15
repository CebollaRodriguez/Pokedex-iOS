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
    @State private var expandView: Bool = false
    @State private var wasChanged: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            
            ZStack {
                
                PokedexView(
                    pokedex: $homeViewModel.selection,
                    wasChanged: $wasChanged,
                    searchText: $searchText
                )
                .padding(.top,65)
                .blur(radius: expandView ? 15 : 0)
                .disabled(expandView)
                VStack {
                    HStack (spacing: 0) {
                        searchBar
                        // animation only if the user starts typing
                            .animation(.easeInOut, value: searchText != "")
                        if searchText == "" {
                            Spacer()
                            DropDown(
                                content: $homeViewModel.pokedexes,
                                selection: $homeViewModel.selection,
                                expandView: $expandView,
                                wasChanged: $wasChanged,
                                activeTint: .primary.opacity(0.1),
                                inActiveTint: .primary.opacity(0.05)
                            )
                            .frame(width: 150)
                            .padding(.trailing, 20)
                            
                            
                        } else {
                            Button {
                                self.searchText = ""
                            } label: {
                                Text("Cancel")
                                    .padding(.trailing, 20)
                            }

                        }
                        
                    }
                    
                    Spacer()
                }
            }
            
        }
        .onAppear{
            homeViewModel.getPokedexeslist()
        }
        
        
        
    }
    var searchBar: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 23, weight: .semibold))
                .foregroundColor(.gray)
            TextField("Search", text: $searchText)
        }
        .padding(.leading, 20)
        .frame(height: 35)
        .background (Color.primary.opacity (0.05))
        .cornerRadius (8)
        .padding(.horizontal, 20)
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
