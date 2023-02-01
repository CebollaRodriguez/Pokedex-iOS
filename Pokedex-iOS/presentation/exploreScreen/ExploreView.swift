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
    @State private var isError: Bool = false
    var body: some View {
        ZStack {
            if viewModel.isLocationAuthorized {
                viewisAuthorized
            } else {
                viewIsNotAuthorized
            }
            pokemonFounded
        }
    }
    
    var viewisAuthorized: some View {
        ZStack {
            VStack {
                MapView(userExplore: $viewModel.userExplore,isLocationEnable: $viewModel.isLocationAuthorized)
                buttonExplore
            }
            
            if isExploring {
                distanceFormat
            }
            
            if viewModel.isGoalComplete {
                pokemonFounded
            }
            
        }
    }
    
    var pokemonFounded: some View {
        VStack {
            Text("Felicidades, encotro un pokemon!!!")
            HStack{
                Button {
                    
                } label: {
                    Text("Atrapar")
                }
                Button {
                    
                } label: {
                    Text("Huir")
                }

            }
        }
        .background(.white)
        .cornerRadius(10)
        .padding(50)
    }
    
    var viewIsNotAuthorized: some View {
        VStack {
            if !isError {
                ProgressView()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.isError = !viewModel.isLocationAuthorized
                        }
                    }
                    .task {
                        viewModel.getCurrentLocation()
                    }
            } else {
                Rectangle()
                    .foregroundColor(.gray)
                
                buttonPerrmisionAuthorization
            }
            
            
        }
    }
    
    var distanceFormat: some View {
        VStack {
            HStack {
                Group{
                    Label("\(viewModel.distanceTravel) meters", systemImage: "figure.walk")
                        .foregroundColor(.gray)
                        .padding(10)
                }
                .background(.white)
                .cornerRadius(10)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
    
    var buttonPerrmisionAuthorization: some View {
        VStack {
            Link("Press here to change the location authorization and explore the Pokemon's World", destination: URL(string: UIApplication.openSettingsURLString)!)
                .padding()
        }
    }
    
    var buttonExplore: some View {
        VStack {
            
            Button {
                self.isExploring.toggle()
                
                if isExploring {
                    viewModel.getDistance()
                } else {
                    viewModel.stopTracking()
                }
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
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}


