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
    
    var pokemons:[PokemonResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemon1Lbl.text = pokemons[0].name
        pokemon2NameLbl.text = pokemons[1].name
    }
}
