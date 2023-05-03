//
//  PokemonData.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 2/05/23.
//

import Foundation


struct PokemonResponse: Decodable{
        let id: Int?
        let name:String?
        let height: Int?
        let weight: Int?
        let url: String?
        let hp: Int?
        let type: String?
        let attack : Int?
        let defense: Int?
}

