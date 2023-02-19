//
//  ExploreView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 28/01/23.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel: ExploreViewModel = .build()
    @Environment(\.managedObjectContext) private var moc
    @State private var isExploring = false
    @State private var isError: Bool = false

    var body: some View {
        ZStack {
            if viewModel.isLocationAuthorized {
                viewIsAuthorized
            } else {
                viewIsNotAuthorized
            }
        }
    }
    
    var viewIsAuthorized: some View {
        ZStack {
            VStack {
                MapView(userExplore: $viewModel.userExplore,isLocationEnable: $viewModel.isLocationAuthorized)
                buttonExplore
            }
            .blur(radius: viewModel.isGoalComplete ? 15 : 0)
            .disabled(viewModel.isGoalComplete)
            
            if isExploring {
                distanceFormat
            }
            
            if viewModel.isGoalComplete {
                pokemonFounded
                    
            }
            
        }
        .onAppear {
            viewModel.getPokedexList()
            
        }
    }
    
    var pokemonFounded: some View {
        VStack {
            var pokemonUrl: String = viewModel.pokemonFounded?.url ?? ""
            var pokemonName: String = viewModel.pokemonFounded?.name ?? ""
            
            Text("Pokemon Founded!!!")
                .font(.callout)
            Text("A wild \(pokemonName.firstUpper()) was founded")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top,10)
            PokemonImage(id: pokemonUrl.getPokemonIdByUrl(), width: 80, height: 80)
            
            Button {
                viewModel.isGoalComplete = false
            } label: {
                HStack {
                    
                    Text("Close")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                    
                }
                .background(.blue)
                
                
            }
            .cornerRadius(10)
            .padding(.top)
        }
        .padding(30)
        .background(.white)
        .cornerRadius(10)
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


