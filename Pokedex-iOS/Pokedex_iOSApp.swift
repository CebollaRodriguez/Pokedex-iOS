//
//  Pokedex_iOSApp.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 20/12/22.
//

import SwiftUI
import Firebase
import FacebookLogin

class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        return true
    }
}

@main
struct Pokedex_iOSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared
    

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(SessionManager())
            //ContentView()
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
