//
//  PokemonView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI

struct PokemonView: View {
    let pokemonId: Int
    @StateObject private var viewModel: PokemonViewModel = .build()
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.model.pokemonEvolutions, id: \.evoName) { evo in
                    Text(evo.evoId)
                }
            }
            .onAppear{
                viewModel.getPokemon(id: pokemonId)
            }
            .navigationTitle()
        }
    }
}


struct PokemonView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonView(pokemonId: 1)
    }
}
