//
//  Pokedex_iOSApp.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 20/12/22.
//

import SwiftUI

@main
struct Pokedex_iOSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
            //ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
