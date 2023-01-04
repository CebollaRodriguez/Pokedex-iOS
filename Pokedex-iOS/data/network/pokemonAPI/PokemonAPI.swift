//
//  PokemonAPI.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation

final class PokemonAPI {
    func listPokedexes(completion: @escaping(Result<ListPokedexesResponse?, Error>) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokedex")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                let pokedexes = try? JSONDecoder().decode(ListPokedexesResponse.self, from: data)
                completion(.success(pokedexes))

            }
        }
        .resume()
    }
    
    func onePokedex(url:String, completion: @escaping(Result<PokedexResponse?, Error>) -> Void) {
        let pokedexUrl = URL(string: url)
        URLSession.shared.dataTask(with: pokedexUrl!) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            print(String(describing: data).utf8)
            if let data = data {
                let pokedex = try? JSONDecoder().decode(PokedexResponse.self, from: data)
                completion(.success(pokedex))
            }
        }
        .resume()
    }
    
}
