//
//  PokemonAPI.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 04/01/23.
//

import Foundation
import Alamofire


class PokemonAPI: PokemonApiProtocol {
    private var manager: Alamofire.SessionManager
    init() {
        let configuration: URLSessionConfiguration = {
            let config = URLSessionConfiguration.default
            
            return config
        }()
        
        self.manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    private func request<T: Decodable>(url: String, completionHandler: @escaping(Swift.Result<T?, Error>) -> Void) {
        manager.request(url).validate().response { response in
            if let error = response.error {
                completionHandler(.failure(error))
                print(error.localizedDescription)
                return
            }
            if let data = response.data {
                let jsonData = try? JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(jsonData))
            }
        }
    }
    
    func listPokedexes(completion: @escaping(Swift.Result<ListPokedexesResponse?, Error>) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokedex"
        
        request(url: url, completionHandler: completion)
    }
    
    func onePokedex(url:String, completion: @escaping(Swift.Result<PokedexResponse?, Error>) -> Void) {
        
        
        request(url: url, completionHandler: completion)
    }
    
    func getOnePokemon(id: Int, completion: @escaping(Swift.Result<PokemonResponse?, Error>) -> Void) {
        let pokemonUrl = "https://pokeapi.co/api/v2/pokemon-species/\(id)/"
        
        request(url: pokemonUrl, completionHandler: completion)
    }
    
    func getEvolutionSpecies(url: String, completion: @escaping(Swift.Result<EvolutionResponse?, Error>) -> Void) {
        
        
        request(url: url, completionHandler: completion)
    }
}
