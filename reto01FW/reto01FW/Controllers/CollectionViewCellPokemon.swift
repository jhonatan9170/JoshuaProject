//
//  CollectionViewCellPokemon.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit
import CoreData

class CollectionViewCellPokemon: UICollectionViewCell {
   
    @IBOutlet weak var viewCellPokemon: UIView!
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var lblNamePokemon: UILabel!
    
    @IBOutlet weak var selectCellPokemon: UIButton!
    
    
    @IBOutlet weak var favoriteBtn: UIButton!
    var namePokemon: String?
    
    
    @IBOutlet weak var lblTypePokemon: UILabel!
    
    var imgUrlToFavorite:String?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func awakeFromNib() {
        super.awakeFromNib()
        setRoundedBorder()
    }
    
    func setRoundedBorder() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
    
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        let entidad = NSEntityDescription.entity(forEntityName: "PokemonsFavorite", in: context)!
            let objeto = NSManagedObject(entity: entidad, insertInto: context)
        
        objeto.setValue(lblNamePokemon.text, forKeyPath: "name")
        objeto.setValue(lblTypePokemon.text, forKeyPath: "type")
        objeto.setValue(imgUrlToFavorite, forKeyPath: "img")
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
