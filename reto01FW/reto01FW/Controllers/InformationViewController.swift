//
//  InformationViewController.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 22/04/23.
//

import UIKit

class InformationViewController: UIViewController {
    
     
    
    var namePokemon:String?
    var typePokemon:String?
    var imgPokemon:String?
    var hpPokemon:Int?
    var attackPokemon:Int?
    var defensePokemon:Int?
    var weightPokemon:Int?
    var heightPokemon:Int?
    
    //outlets
    
    let stackWidth = UIScreen.main.bounds.width / 2
    
    
   
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        namePokemonLbl.text = namePokemon
        typePokemonLbl.text = typePokemon
        
        if let attack = attackPokemon {
            attackPokemonLbl.text = String(describing: attack)
        } else {
            attackPokemonLbl.text = "N/A"
        }
        
        if let hp = hpPokemon {
            hpPokemonLbl.text =
            String(describing: hp)
            
        }else{
            hpPokemonLbl.text = "N/A"
        }
        
        if let defense = defensePokemon{
            defensePokemonLbl.text =
            String(describing: defense)
        }else{
            defensePokemonLbl.text = "N/A"
        }
        
        if let weight = weightPokemon{
            weightPokemonLbl.text =
            String(describing: weight)
        }else{
            weightPokemonLbl.text = "N/A"
        }
        
        if let height = heightPokemon{
            heightPokemonLbl.text =
            String(describing: height)
        }else{
            heightPokemonLbl.text = "N/A"
        }
        
        if let url = URL(string : imgPokemon ?? ""){
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
