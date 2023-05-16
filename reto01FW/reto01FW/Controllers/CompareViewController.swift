//
//  CompareViewController.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 24/04/23.
//

import UIKit

class CompareViewController: UIViewController {

    @IBOutlet weak var pokemon1TypeLbl: UILabel!
    @IBOutlet weak var pokemon1Lbl: UILabel!
    @IBOutlet weak var pokemon1AttackLbl: UILabel!
    @IBOutlet weak var pokemon1DefenseLbl: UILabel!
    @IBOutlet weak var pokemon1HoLbl: UILabel!
    @IBOutlet weak var pokemon2NameLbl: UILabel!
    @IBOutlet weak var pokemon2TypeLbl: UILabel!
    @IBOutlet weak var pokemon2HpLbl: UILabel!
    @IBOutlet weak var pokemon2DefenseLbl: UILabel!
    @IBOutlet weak var pokemon2AttackLbl: UILabel!
    @IBOutlet weak var pokemon1Img: UIImageView!
    @IBOutlet weak var pokemon2Img: UIImageView!
    
    var pokemons:[PokemonResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemon1Lbl.text = pokemons[0].name
        pokemon1TypeLbl.text = pokemons[0].types[0].type.name
        pokemon1AttackLbl.text = String(describing: pokemons[0].stats[1].baseStat)
        pokemon1DefenseLbl.text = String(describing: pokemons[0].stats[2].baseStat)
        pokemon1HoLbl.text = String(describing: pokemons[0].stats[0].baseStat)
    
        if let url = URL(string : pokemons[0].sprites.other.officialArtwork.frontDefault ?? ""){
            if let imgData = try? Data(contentsOf: url){
                let image = UIImage(data: imgData)
                pokemon1Img.image = image
            }
        }
        
        
        pokemon2NameLbl.text = pokemons[1].name
        pokemon2TypeLbl.text = pokemons[1].types[0].type.name
        pokemon2HpLbl.text = String(describing: pokemons[1].stats[0].baseStat)
        pokemon2AttackLbl.text = String(describing: pokemons[1].stats[1].baseStat)
        pokemon2DefenseLbl.text = String(describing: pokemons[1].stats[2].baseStat)
        if let url2 = URL(string : pokemons[1].sprites.other.officialArtwork.frontDefault ?? ""){
            if let imgData = try? Data(contentsOf: url2){
                let image = UIImage(data: imgData)
                pokemon2Img.image = image
            }
        }
    }
}
