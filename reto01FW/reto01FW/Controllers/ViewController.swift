//
//  ViewController.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit

class ViewController: UIViewController {
    
    var pokemons:[Pokemon] = []
    
    private let cellWidth = UIScreen.main.bounds.width / 2
    
    // oulets
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var collectioViewPokedex: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pokemon1 = Pokemon(name: "pikachu",type: "electric",img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png", hp: 35, attack: 55, defense: 40, weight: 60, height: 4)
        
        let pokemon2 = Pokemon(name: "charmander", type: "fire", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/4.png", hp: 39, attack: 52, defense: 43, weight: 85, height: 6)
        
        let pokemon3 = Pokemon(name: "squirtle", type: "water", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png", hp: 44, attack: 48, defense: 65, weight: 90, height: 5)
        
        let pokemon4 = Pokemon(name: "bulbasaur", type: "poison", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png", hp: 45, attack: 49, defense: 49, weight: 69, height: 7)
        
        let pokemon5 = Pokemon(name: "eevee", type: "normal", img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/133.png", hp: 55, attack: 55, defense: 50, weight: 65, height: 3)
        
        pokemons = [pokemon1,pokemon2,pokemon3,pokemon4]
        
        // collectionView Pokedex
        collectioViewPokedex.backgroundColor = .red
        
        collectioViewPokedex.dataSource = self
        collectioViewPokedex.delegate = self
        collectioViewPokedex.register(UINib(nibName: "CollectionViewCellPokemon", bundle: nil), forCellWithReuseIdentifier: "cellPokemon")
        
        // btnCompare
        btnCompare.setTitle("Compare", for: .normal)
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
        
        
        let urld = URL(string: pokemon.img)!
        
        if let data = try? Data(contentsOf:urld) {
                // Create Image and Update Image View
            cell!.imgPokemon.image = UIImage(data: data)
            }
        return cell!
    }
    
    
}

extension ViewController: UICollectionViewDelegate{
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}

