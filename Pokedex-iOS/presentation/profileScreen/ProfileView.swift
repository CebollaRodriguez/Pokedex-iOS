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
                            Text("Link Email")
                        }
                    }
                    .disabled(profileViewModel.isEmailAndPasswordLinked())
                    Button {
                        profileViewModel.userLinkFacebook()
                    } label: {
                        HStack {
                            Image("facebook_ic")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Link Facebook")
                        }
                        
                    }
                    .disabled(profileViewModel.isFacebookLinked())
                } header: {
                    Text("Link other accounts with this session")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
                .task{
                    profileViewModel.getCurrentProvider()
                }
                .alert(profileViewModel.isAccountLinked ? "Linked Account" : "Linking account error", isPresented: $profileViewModel.showAlert) {
                    Button("Accept") {
                                
                    }
                } message: {
                    Text(profileViewModel.isAccountLinked ? "✅ Your account was linked succesful!" : "❌ Error linking facebook account")
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
