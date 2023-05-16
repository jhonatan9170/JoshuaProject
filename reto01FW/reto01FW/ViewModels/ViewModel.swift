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
    
    func getPokemonList(completion: @escaping (Result<[PokemonResponse], Error>) -> Void) {
        let url = "https://pokeapi.co/api/v2/pokemon?limit=20"

        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: PokemonListResponse.self) { response in
            switch response.result {
            case .success(let pokemonListResponse):
                let pokemonList = pokemonListResponse.results.map { item in
                    PokemonListItem(name: item.name, url: item.url)
                }
                let dispatchGroup = DispatchGroup()
                var pokemonArray = [PokemonResponse]()
                for pokemonListItem in pokemonList {
                    dispatchGroup.enter()
                    print("aqui",pokemonListItem)
                    
                    
                    AF.request(pokemonListItem.url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: PokemonResponse.self) { response in
                            switch response.result {
                            case .success(let pokemonResponse):
                                print("hola")
                                pokemonArray.append(pokemonResponse)
                                dispatchGroup.leave()
                                print("hola",pokemonArray.count)
                            case .failure(let error):
                                completion(.failure(error))
                            }
                        }

                }
                dispatchGroup.notify(queue: .main) {
                    completion(.success(pokemonArray))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }


    }
    
    
    
    

}
