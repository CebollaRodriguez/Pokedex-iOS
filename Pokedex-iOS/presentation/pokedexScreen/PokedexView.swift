//
//  PokedexView.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import SwiftUI

struct PokedexView: View {
    let pokedexUrl: String
    @StateObject private var viewModel: PokedexViewModel = .build()
    var body: some View {
        VStack {
            Text(viewModel.model.pokedexName)
        }
        .onAppear{
            viewModel.getPokedex(url: pokedexUrl)
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView(pokedexUrl:"https://pokeapi.co/api/v2/pokedex/1/")
    }
}
