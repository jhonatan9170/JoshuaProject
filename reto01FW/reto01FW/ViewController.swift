//
//  ViewController.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit

class ViewController: UIViewController {

    // variables
    private let myPokemonCollection = [("charmander","https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png","fuego"),("pikachu",  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png","electricidad" ),("squirtle","https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png", "agua"),("bulbasaur","https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png","planta")]
    
    private let cellWidth = UIScreen.main.bounds.width / 2
    
    // oulets
    @IBOutlet weak var btnCompare: UIButton!
    @IBOutlet weak var collectioViewPokedex: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        return myPokemonCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectioViewPokedex.dequeueReusableCell(withReuseIdentifier: "cellPokemon", for: indexPath) as? CollectionViewCellPokemon
        
        cell!.lblNamePokemon.text = myPokemonCollection[indexPath.row].0
        cell!.lblTypePokemon.text = myPokemonCollection[indexPath.row].2
        
        
        let urld = URL(string: myPokemonCollection[indexPath.row].1)!
        
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

