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
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                PokedexView(
                    pokedex: $homeViewModel.selection,
                    wasChanged: $wasChanged
                )
                .padding(.top,65)
                .blur(radius: expandView ? 15 : 0)
                .disabled(expandView)
                VStack {
                    HStack {
                        DropDown(
                            content: $homeViewModel.pokedexes,
                            selection: $homeViewModel.selection,
                            expandView: $expandView,
                            wasChanged: $wasChanged,
                            activeTint: .primary.opacity(0.1),
                            inActiveTint: .primary.opacity(0.05)
                        )
                        .frame(width: 180)
                        .padding(.leading, 20)
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            
        }
        .onAppear{
            homeViewModel.getPokedexeslist()
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
