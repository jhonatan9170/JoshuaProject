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
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    func getPokemon(id: Int){
        let url = "\(baseUrl)\(id)"
        AF.request(url, method: .get).validate(statusCode: 200...299).responseDecodable (of: PokemonResponse.self) {response in
            
            if let pokemonName = response.value?.name{
                print(pokemonName)
            }else{
                print(response.error?.responseCode ?? "No error")
            }
        }
    }
    
}
