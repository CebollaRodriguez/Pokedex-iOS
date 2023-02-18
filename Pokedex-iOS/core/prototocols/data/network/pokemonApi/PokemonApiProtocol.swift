//
//  PokemonApiProtocol.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 06/01/23.
//

import Foundation


protocol PokemonApiProtocol: AnyObject {
    
    func listPokedexes(completion: @escaping(Result<ListPokedexesResponse?, Error>) -> Void)
    
    func onePokedex(url:String, completion: @escaping(Result<PokedexResponse?, Error>) -> Void)
    
    func getOnePokemon(id: Int, completion: @escaping(Result<PokemonResponse?, Error>) -> Void)
    
    func getEvolutionSpecies(url: String, completion: @escaping(Result<EvolutionResponse?, Error>) -> Void)
}
