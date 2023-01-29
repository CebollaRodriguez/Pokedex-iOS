//
//  ExploreView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel: ExploreViewModel = .build()
    @State private var isExploring = false
    var body: some View {
        VStack {
            
            MapView(userExplore: $viewModel.userExplore,isLocationEnable: $viewModel.isLocationAuthorized)
            buttonExplore
        }
        .task {
            viewModel.getCurrentLocation()
        }
    }
    

    var buttonExplore: some View {
        VStack {
            
            Button {
                self.isExploring.toggle()
            } label: {
                HStack {
                    Spacer()
                    Text(isExploring ? "Stop" : "Start")
                        .foregroundColor(.black)
                        .padding(.vertical)
                    Spacer()
                }
                .background(.white)
                .cornerRadius(15)
                .shadow(radius: 6)
            }
            .padding()

        }
        .padding(.bottom, 20)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}


