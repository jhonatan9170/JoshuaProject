//
//  PokemonData.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 2/05/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import Alamofire
struct PokemonListResponse: Codable{
    let count: Int
    let results: [PokemonListItem]
}
struct PokemonListItem: Codable{
    let name: String
    let url: String
}

// MARK: - PokemonResponse
struct PokemonResponse: Codable {
    let id: Int
    let stats: [StatElement]
    let types: [TypeElement]
    let weight, height: Int
    let sprites: Sprites
    let name: String
    let baseExperience, order: Int

    enum CodingKeys: String, CodingKey {
        case id, stats, types, weight, height, sprites, name
        case baseExperience = "base_experience"
        case order
    }
}

// MARK: - Sprites
struct Sprites: Codable {
    let other: Other
}

// MARK: - Other
struct Other: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - StatElement
struct StatElement: Codable {
    let baseStat, effort: Int
    let stat: TypeClass

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort, stat
    }
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let name: String
    let url: String
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let slot: Int
    let type: TypeClass
}
