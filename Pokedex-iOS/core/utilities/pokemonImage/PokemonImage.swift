//
//  PokemonImage.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 13/02/23.
//

import SwiftUI

struct PokemonImage: View {
    // Pokemon Image Properties
    var id: String
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
        ) { image in
            image
                .resizable()
                .frame(width: self.width, height: self.height)
        } placeholder: {
            ProgressView()
            
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(id: "2",  width: 80, height: 80)
    }
}
