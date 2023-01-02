//
//  ProfileView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/01/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionManager
    @StateObject private var profileViewModel: ProfileViewModel = .build()
    
    var body: some View {
        
            VStack {
                Form {
                    Section {
                        Button {
                            
                        } label: {
                            HStack {
                                Image(systemName: "envelope.fill")
                                Text("Link to Email")
                            }
                            
                        }
                        Button {
                            
                        } label: {
                            HStack {
                                Image("facebook_ic")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("Link to Facebook")
                            }
                            
                        }
                    }
                }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Profile")
            .toolbar {
                Button("Logout") {
                    profileViewModel.userLogOut()
                    session.localLogOut()
                }
            }
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
