//
//  PokemonFavorite+CoreDataProperties.swift
//  Pokedex-iOS
//
//  Created by Gabriel Sanchez Peraza on 02/02/23.
//
//

import Foundation
import CoreData


extension PokemonFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonFavorite> {
        return NSFetchRequest<PokemonFavorite>(entityName: "PokemonFavorite")
    }

    @NSManaged public var pokemonId: Int32
    @NSManaged public var name: String?
    @NSManaged public var uuid: UUID?


}

extension PokemonFavorite : Identifiable {

}
