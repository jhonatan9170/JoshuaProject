//
//  CollectionViewCellPokemon.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit
import CoreData

class CollectionViewCellPokemon: UICollectionViewCell {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var viewCellPokemon: UIView!
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var lblNamePokemon: UILabel!
    
    @IBOutlet weak var selectCellPokemon: UIButton!
    
    
    @IBOutlet weak var favoriteBtn: UIButton!
    var namePokemon: String?
    
    
    @IBOutlet weak var lblTypePokemon: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
        
      
    }

    @IBAction func favoriteAction(_ sender: UIButton) {
        let entidad = NSEntityDescription.entity(forEntityName: "PokemonsFavorite", in: context)!
            let objeto = NSManagedObject(entity: entidad, insertInto: context)

            // Establece los valores de los atributos de la entidad con los datos que deseas almacenar
        objeto.setValue(lblNamePokemon.text, forKeyPath: "name")
        objeto.setValue(lblTypePokemon.text, forKey: "type")

            // Guarda los cambios en Core Data
            do {
                try context.save()
                print(lblNamePokemon.text as Any)
                print("Datos guardados exitosamente")
            } catch let error as NSError {
                print("No se pudo guardar los datos. \(error), \(error.userInfo)")
            }
    }
}
