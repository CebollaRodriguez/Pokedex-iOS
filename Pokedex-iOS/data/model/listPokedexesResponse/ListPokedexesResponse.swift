//
//  ListPokedexesResponse.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

struct ListPokedexesResponse: Decodable{
    let results: [ListPokedexModel]
}

struct ListPokedexModel: Decodable {
    let name: String
    let url: String
}
