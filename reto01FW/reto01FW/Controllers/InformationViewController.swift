//
//  InformationViewController.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 22/04/23.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var oneStack: UIStackView!
    @IBOutlet weak var twoStack: UIStackView!
    @IBOutlet weak var namePokemonLbl: UILabel!
    @IBOutlet weak var typePokemonLbl: UILabel!
    @IBOutlet weak var hpPokemonLbl: UILabel!
    @IBOutlet weak var attackPokemonLbl: UILabel!
    @IBOutlet weak var defensePokemonLbl: UILabel!
    @IBOutlet weak var weightPokemonLbl: UILabel!
    @IBOutlet weak var heightPokemonLbl: UILabel!
    @IBOutlet weak var informatioImageView: UIImageView!
    
    var pokemon: PokemonResponse?
    let stackWidth = UIScreen.main.bounds.width / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namePokemonLbl.text = pokemon?.name
        typePokemonLbl.text = pokemon?.types[0].type.name
        if let attack = pokemon?.stats[1].baseStat{
            attackPokemonLbl.text = String(describing: attack)
        }
        
        if let hp = pokemon?.stats[0].baseStat {
            hpPokemonLbl.text =
            String(describing: hp)
        }
        
        if let defense = pokemon?.stats[2].baseStat{
            defensePokemonLbl.text =
            String(describing: defense)
        }
        
        if let weight = pokemon?.weight{
            weightPokemonLbl.text =
            String(describing: weight)
        }
        
        if let height = pokemon?.height{
            heightPokemonLbl.text =
            String(describing: height)
        }
        
        if let url = URL(string : pokemon?.sprites.other.officialArtwork.frontDefault ?? ""){
            if let imgData = try? Data(contentsOf: url){
                let image = UIImage(data: imgData)
                informatioImageView.image = image
            }
        }
            
        oneStack.widthAnchor.constraint(equalToConstant: stackWidth).isActive = true
        
        twoStack.widthAnchor.constraint(equalToConstant: stackWidth).isActive = true
    }
    
}
