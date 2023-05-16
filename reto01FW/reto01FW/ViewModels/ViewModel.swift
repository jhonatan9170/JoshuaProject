//
//  ViewModel.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 15/05/23.
//

import Foundation
import Alamofire

protocol ViewDelegate: AnyObject {
    func didLoadPokemonList(_ pokemonList: [PokemonResponse])
    func didFailWithError(_ error: Error)
}


class ViewModel {
    
    var pokemonList = [PokemonResponse]()
    
    weak var delegate: ViewDelegate?
    
//    func getPokemonList(completion: @escaping (Result<[PokemonResponse], Error>) -> Void) {
//        let url = "https://pokeapi.co/api/v2/pokemon?limit=20"
//
//        AF.request(url).responseDecodable(of: PokemonListResponse.self) { response in
//              switch response.result {
//              case .success(let result):
//                  for element in result{
//                     
//                  }
//                  completion(pokemonList,nil)
//              case .failure(let error):
//                  print(nil, error)
//              }
//          }
//
//
//    }
    
    func getPokemonList(completion: @escaping ([PokemonResponse]?, Error?) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon?limit=20"

        AF.request(url).responseDecodable(of: PokemonListResponse.self) { response in
            switch response.result {
            case .success(let listResponse):
                let dispatchGroup = DispatchGroup()
                var pokemonResponses: [PokemonResponse] = []

                for item in listResponse.results {
                    dispatchGroup.enter()
                    AF.request(item.url).responseDecodable(of: PokemonResponse.self) { response in
                        defer {
                            dispatchGroup.leave()
                        }

                        switch response.result {
                        case .success(let pokemonResponse):
                            pokemonResponses.append(pokemonResponse)
                        case .failure(let error):
                            completion(nil, error)
                        }
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    completion(pokemonResponses, nil)
                }

            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    
    
    
    

}
