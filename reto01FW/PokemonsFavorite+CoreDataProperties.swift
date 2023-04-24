//
//  PokemonsFavorite+CoreDataProperties.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 23/04/23.
//
//

import Foundation
import CoreData


extension PokemonsFavorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonsFavorite> {
        return NSFetchRequest<PokemonsFavorite>(entityName: "PokemonsFavorite")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var img: String?

}

extension PokemonsFavorite : Identifiable {

}
