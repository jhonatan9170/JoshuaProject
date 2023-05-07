//
//  NetworkingProvider.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 2/05/23.
//

import Foundation
import Alamofire
final class NetworkingProvider{
    static let shared = NetworkingProvider()
    private let baseUrl = "https://pokeapi.co/api/v2"
    
    private init() {}

    func fetchPokemonDetails(id: Int) async throws -> PokemonResponse {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("https://pokeapi.co/api/v2/pokemon/\(id)").validate().responseDecodable(of: PokemonResponse.self) { response in
                switch response.result {
                case .success(let pokemonResponse):
                    continuation.resume(returning: pokemonResponse)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
        
func fetchPokemonList(completion: @escaping (Result<[PokemonResponse], Error>) -> Void) {
            let offset = 0
            let limit = 20
            AF.request("https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)").responseDecodable(of: PokemonList.self) { response in
                switch response.result {
                case .success(let pokemonList):
                    completion(.success(pokemonList.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
