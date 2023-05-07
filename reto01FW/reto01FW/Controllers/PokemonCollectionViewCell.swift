//
//  CollectionViewCellPokemon.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit
import CoreData

class PokemonCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var viewCellPokemon: UIView!
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lblNamePokemon: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var lblTypePokemon: UILabel!
    
    var stateFavorite: Bool?
    var state: Bool?
    var namePokemon: String?
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
        
        if self.stateFavorite == true {

            let fetchRequest: NSFetchRequest<PokemonsFavorite> = PokemonsFavorite.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", lblNamePokemon.text ?? "")
        
            do {
                let pokemonToDelete = (try context.fetch(fetchRequest).first)!
                    context.delete(pokemonToDelete)
                do {
                    try context.save()
                    print("datos guardados exitosamente")
                } catch {
                    print("Error saving context: \(error.localizedDescription)")
                }
            } catch {
                print("Error deleting pokemon: \(error.localizedDescription)")
            }

            favoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            self.stateFavorite = false
        }else{
            print("no entro")
            favoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
            let objeto = NSManagedObject(entity: entidad, insertInto: context)
            
            objeto.setValue(lblNamePokemon.text, forKeyPath: "name")
            objeto.setValue(lblTypePokemon.text, forKeyPath: "type")
            objeto.setValue(imgUrlToFavorite, forKeyPath: "img")
                do {
                    try context.save()
                    print(lblNamePokemon.text as Any)
                    print("Datos guardados exitosamente")
                } catch let error as NSError {
                    print("No se pudo guardar los datos. \(error), \(error.userInfo)")
                }
            self.stateFavorite = true
        }
    }
}
