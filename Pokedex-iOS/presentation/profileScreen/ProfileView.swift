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
    @State private var isClick = false
    @State private var wantDelete = false
    @State private var emailText = ""
    @State private var passwordText = ""
    var body: some View {
        
        ZStack {
            VStack {
                Form {
                    buttonsLink
                    buttonsAccount
                }
                .alert(profileViewModel.isDelete ? "Account deleted" : "An error has occurred", isPresented: $profileViewModel.showDeleteAlert) {
                    Button("Accept") {
                        if profileViewModel.isDelete {
                            session.localLogOut()
                        }
                    }
                } message: {
                    Text(profileViewModel.isDelete ? "✅ Your account was deleted successful" : "❌ Error deleting your account, contact with support")
                }
                
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Profile")
        
    }
    
    var linkEmailView: some View {
        VStack {
            Group {
                Text("Enter your email to link it to this account ")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .padding(.top,2)
                TextField("Email",text: $emailText)
                TextField("Password",text:  $passwordText)
                Button {
                    profileViewModel.userLinkEmailAndPassword(email: emailText, password: passwordText)
                } label: {
                    Text("Link email")
                        .padding(.horizontal, 20)
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                
                
            }
            .textFieldStyle(.roundedBorder)
        }
        .padding(.horizontal,10)
    }
    
    
    var buttonsAccount: some View {
        Section {
            VStack (spacing: 10) {
                Button {
                    profileViewModel.userLogOut()
                    session.localLogOut()
                } label: {
                    HStack {
                        Spacer()
                        Text("Log Out")
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                    .background(.blue)
                    .cornerRadius(30)
                }
                Button {
                    self.wantDelete.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("Delete account")
                            .foregroundColor(.white)
                            .padding()
                        
                        Spacer()
                    }
                    .background(.red)
                    .cornerRadius(30)
                }
                
            }
            
            
        } header: {
            Text("Account actions")
        }
        .alert("Delete Account", isPresented: self.$wantDelete) {
            HStack{
                Button("Cancel") {
                    self.wantDelete = false
                }
                Button("Delete") {
                    profileViewModel.deleteAccount()
                }
            }
        } message: {
            Text("Do you want to delete your account?")
            
        }
    }
    
    var buttonsLink: some View {
        Section {
            Button {
                self.isClick.toggle()
            } label: {
                VStack {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .frame(width: 20, height: 20)
                        Text("Link Email")
                        Spacer()
                    }
                    if self.isClick {
                        linkEmailView
                    }
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
            Button {
                profileViewModel.userLinkGoogle()
            } label: {
                HStack {
                    Image("google_logo")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("Link Google")
                }
            }
            .disabled(profileViewModel.isGoogleLinked())
            
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
                self.isClick = false
            }
        } message: {
            Text(profileViewModel.isAccountLinked ? "✅ Your account was linked succesful!" : "❌ Error linking your account")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
