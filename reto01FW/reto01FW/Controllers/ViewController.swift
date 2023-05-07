//
//  ViewController.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var collectioViewPokedex: UICollectionView!
    @IBOutlet weak var compareStateBtn: UIButton!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    var numPokemonSelected = 0
    var comparePokemonState = false
    var pokemons:[PokemonResponse] = []
    var filteredPokemon = [PokemonResponse]()
    var pokemonsToCompare = [PokemonResponse]()
    
    private let cellWidth = UIScreen.main.bounds.width / 2
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private var myPokemonsFavorite:[PokemonsFavorite]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        async {
            await getListPokemon()
            collectioViewPokedex.dataSource = self
            collectioViewPokedex.delegate = self
            collectioViewPokedex.register(UINib(nibName: "CollectionViewCellPokemon", bundle: nil), forCellWithReuseIdentifier: "cellPokemon")
            
            btnCompare.setTitle("Compare", for: .normal)
            
            pokemonSearchBar.delegate = self
        }
    }
    
    func getListPokemon() async {
        for id in 1...20 {
                do {
                    let pokemon = try await NetworkingProvider.shared.fetchPokemonDetails(id: id)
                    print(pokemon.name)
                    self.pokemons.append(pokemon)
                } catch {
                    print("Error")
                    print(error.localizedDescription)
                }
            }
    }

    @IBAction func compareStateAction(_ sender: Any) {

       comparePokemonState = !comparePokemonState
        if comparePokemonState == true {
            compareStateBtn.setImage(UIImage(systemName: "seal.fill"),for: .normal)
        }else{
            compareStateBtn.setImage(UIImage(systemName: "seal"),for: .normal)
        }
    }
    
    @IBAction func compareBtnAction(_ sender: Any) {
        performSegue(withIdentifier: "compareSegue", sender: pokemonsToCompare)
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectioViewPokedex.dequeueReusableCell(withReuseIdentifier: "cellPokemon", for: indexPath) as? PokemonCollectionViewCell
        
        let pokemon = pokemons[indexPath.row]
        cell!.lblNamePokemon.text = pokemon.name
        cell!.lblTypePokemon.text = pokemon.types[0].type.name
        cell!.imgUrlToFavorite = pokemon.sprites.other?.officialArtwork.frontDefault
        let urld = URL(string: pokemon.sprites.other?.officialArtwork.frontDefault ?? "")!
        
        if let data = try? Data(contentsOf:urld) {
            cell!.imgPokemon.image = UIImage(data: data)
            }

        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "informationSegue"{
            if let destinationVC = segue.destination as? InformationViewController{
                if let pokemon = sender as? PokemonResponse {
                    destinationVC.pokemon = pokemon
                }
            }
        }else{
            guard let destinoVC = segue.destination as? CompareViewController else {
                return
            }
            destinoVC.pokemons = pokemonsToCompare
        }
            
    }
    
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        
        if comparePokemonState == true {
            
            let cell = collectioViewPokedex.cellForItem(at: indexPath) as! PokemonCollectionViewCell
            
            let countPokemonsToCompare = pokemonsToCompare.count
            let stateCell = cell.state
            if countPokemonsToCompare >= 2{
                if stateCell == true {
                    cell.state = false
                    cell.contentView.backgroundColor = .white
                    pokemonsToCompare.removeAll() {$0.name == pokemon.name}
                }else{
                   print("nose pueden agregar mas pokemones")
                }
            }else {
                if stateCell == true {
                    cell.state = false
                    cell.contentView.backgroundColor = .white
                    pokemonsToCompare.removeAll() {$0.name == pokemon.name}
                }else{
                    cell.state = true
                    cell.contentView.backgroundColor = .blue
                    pokemonsToCompare.append(pokemon)
                }
            }
                
        }else{
            performSegue(withIdentifier: "informationSegue", sender: pokemon)
        }
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellWidth / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }

}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredPokemon = pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                pokemons = filteredPokemon
                } else {
                    async{
                        await getListPokemon()
                    }
                }
        view.endEditing(true)
        collectioViewPokedex.reloadData()

    }
}

