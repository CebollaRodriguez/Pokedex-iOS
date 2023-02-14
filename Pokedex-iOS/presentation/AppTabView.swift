//
//  AppTabView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 11/02/23.
//

import SwiftUI

struct AppTabView: View {
    
    @Environment(\.managedObjectContext) private var moc

    var body: some View {
        NavigationView {
            TabView {
                HomeView()
                .environment(\.managedObjectContext, self.moc)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                ExploreView()
                    .environment(\.managedObjectContext, self.moc)
                    .tabItem {
                       Label("Explore", systemImage: "map.fill")
                    }
                FavoriteView()
                    .environment(\.managedObjectContext, self.moc)
                    .tabItem {
                        Label("Favorite", systemImage: "star")
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ProfileView()
                    } label: {
                        Image(systemName: "person.fill")
                            
                    }
                }
                

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
