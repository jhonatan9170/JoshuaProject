//
//  ViewController.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var numPokemonSelected = 0
    var comparePokemonState = false
    var pokemons:[Pokemon] = []
    var filteredPokemon = [Pokemon]()
    var pokemonArray = [Pokemon]()
    var pokemonsToCompare = [Pokemon]()
    
    private let cellWidth = UIScreen.main.bounds.width / 2
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private var myPokemonsFavorite:[PokemonsFavorite]?
    
    // oulets
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var collectioViewPokedex: UICollectionView!
    
    @IBOutlet weak var compareStateBtn: UIButton!
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pokemon1 = Pokemon(name: "pikachu",type: "electric",img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png", hp: 35, attack: 55, defense: 40, weight: 60, height: 4)
        
        let pokemon2 = Pokemon(name: "charmander", type: "fire", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png", hp: 39, attack: 52, defense: 43, weight: 85, height: 6)
        
        let pokemon3 = Pokemon(name: "squirtle", type: "water", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png", hp: 44, attack: 48, defense: 65, weight: 90, height: 5)
        
        let pokemon4 = Pokemon(name: "bulbasaur", type: "poison", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png", hp: 45, attack: 49, defense: 49, weight: 69, height: 7)
        
        let pokemon5 = Pokemon(name: "eevee", type: "normal", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png", hp: 55, attack: 55, defense: 50, weight: 65, height: 3)
        let pokemon6 = Pokemon(name: "eevee", type: "normal", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png", hp: 55, attack: 55, defense: 50, weight: 65, height: 3)
        let pokemon7 = Pokemon(name: "eevee", type: "normal", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png", hp: 55, attack: 55, defense: 50, weight: 65, height: 3)
        
        pokemonArray = [pokemon1,pokemon2,pokemon3,pokemon4,pokemon5,pokemon6,pokemon7]
        
        pokemons = [pokemon1,pokemon2,pokemon3,pokemon4,pokemon5,pokemon6,pokemon7]
        
        // collectionView Pokedex
        collectioViewPokedex.dataSource = self
        collectioViewPokedex.delegate = self
        collectioViewPokedex.register(UINib(nibName: "CollectionViewCellPokemon", bundle: nil), forCellWithReuseIdentifier: "cellPokemon")
        
        // btnCompare
        btnCompare.setTitle("Compare", for: .normal)
        
        // pokemonSearchBar
        pokemonSearchBar.delegate = self
    }

    @IBAction func compareStateAction(_ sender: Any) {
        NetworkingProvider.shared.getPokemon(id: 25)
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

extension ViewController: UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectioViewPokedex.dequeueReusableCell(withReuseIdentifier: "cellPokemon", for: indexPath) as? CollectionViewCellPokemon
        
        let pokemon = pokemons[indexPath.row]
        
        cell!.lblNamePokemon.text = pokemon.name
        cell!.lblTypePokemon.text = pokemon.type
        cell!.imgUrlToFavorite = pokemon.img
        let urld = URL(string: pokemon.img)!
        
        if let data = try? Data(contentsOf:urld) {
                // Create Image and Update Image View
            cell!.imgPokemon.image = UIImage(data: data)
            }
        
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "informationSegue"{
            if let destinationVC = segue.destination as? InformationViewController{
                if let pokemon = sender as? Pokemon {
                    destinationVC.pokemon = pokemon
                }
            }
        }else{
            guard let destinoVC = segue.destination as? CompareViewController else {
                return
            }
            destinoVC.pokemons = pokemons
        }
            
    }
    
}


extension ViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        
        if comparePokemonState == true {
            
            let pokemonStateToCompare = validateStateToCompare()
            let validateFavoriteState = validatePokemonsSelected(pokemonName: pokemon.name)
            let cell = collectioViewPokedex.cellForItem(at: indexPath) as! CollectionViewCellPokemon
                
            
            if pokemonStateToCompare == true {
                if validateFavoriteState == true{
                    pokemonsToCompare.removeAll() {$0.name == pokemon.name}
                    cell.contentView.backgroundColor = .white
                    print("fondo blanco")
                }else{
                    cell.contentView.backgroundColor = .green
                    pokemonsToCompare.append(pokemon)
                }
            }else{
                print("no se puede agregar mas pokemones para comparar")
                if validateFavoriteState == true{
                    pokemonsToCompare.removeAll() {$0.name == pokemon.name}
                    cell.contentView.backgroundColor = .red
                }else{
                    print("no se pueden seleccionar mas")
                }
            }
        }else{
            performSegue(withIdentifier: "informationSegue", sender: pokemon)
        }
    }
    
    func validateStateToCompare()-> Bool{
        if pokemonsToCompare.count <= 1 {
            return true
        }else {
            return false
        }
    }
    
    func validatePokemonsSelected(pokemonName: String)->Bool{
        if let pokemonFind = pokemonsToCompare.first(where: {$0.name == pokemonName }){
            return true
        }else {
            return false
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellWidth / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10 // Establece el espacio vertical entre celdas en 10 puntos
       }

}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredPokemon = pokemonArray.filter { $0.name.lowercased().contains(searchText.lowercased()) }
                pokemons = filteredPokemon
                } else {
                    pokemons = pokemonArray
                }
        collectioViewPokedex.reloadData()
        print("hola")
        
    }
}

