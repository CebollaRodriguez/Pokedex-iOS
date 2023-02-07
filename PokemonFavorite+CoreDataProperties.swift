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

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var url: String?

}

extension PokemonFavorite : Identifiable {

}
