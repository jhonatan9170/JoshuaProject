//
//  CompareViewController.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 24/04/23.
//

import UIKit

class CompareViewController: UIViewController {

    var pokemons:[Pokemon] = []
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemon1Lbl.text = pokemons[0].name
        pokemon2NameLbl.text = pokemons[1].name
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
