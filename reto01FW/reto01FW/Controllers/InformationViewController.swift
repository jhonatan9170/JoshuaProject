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
    
    var pokemon: Pokemon?
    let stackWidth = UIScreen.main.bounds.width / 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(pokemon ?? "","aqui")
        namePokemonLbl.text = pokemon?.name
        typePokemonLbl.text = pokemon?.type
        if let attack = pokemon?.attack{
            attackPokemonLbl.text = String(describing: attack)
        }
        
        if let hp = pokemon?.hp {
            hpPokemonLbl.text =
            String(describing: hp)
        }
        
        if let defense = pokemon?.defense{
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
        
        if let url = URL(string : pokemon?.img ?? ""){
            if let imgData = try? Data(contentsOf: url){
                let image = UIImage(data: imgData)
                informatioImageView.image = image
            }
        }
            
        oneStack.widthAnchor.constraint(equalToConstant: stackWidth).isActive = true
        
        twoStack.widthAnchor.constraint(equalToConstant: stackWidth).isActive = true
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
