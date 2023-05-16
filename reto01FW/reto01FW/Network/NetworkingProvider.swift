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
        
//    func getPokemonList(completion: @escaping (Result<[PokemonResponse], Error>) -> Void) {
//        let url = "https://pokeapi.co/api/v2/pokemon?limit=20"
//
//        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: PokemonListResponse.self) { response in
//            switch response.result {
//            case .success(let pokemonListResponse):
//                let pokemonList = pokemonListResponse.results.map { item in
//                    PokemonListItem(name: item.name, url: item.url)
//                }
//                let dispatchGroup = DispatchGroup()
//                var pokemonArray = [PokemonResponse]()
//                for pokemonListItem in pokemonList {
//                    dispatchGroup.enter()
//                    pokemonListItem.toPokemon { result in
//                        switch result {
//                        case .success(let pokemon):
//                            pokemonArray.append(pokemon)
//                            dispatchGroup.leave()
//                        case .failure(let error):
//                            completion(.failure(error))
//                        }
//                    }
//                }
//                dispatchGroup.notify(queue: .main) {
//                    completion(.success(pokemonArray))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    


    
}
