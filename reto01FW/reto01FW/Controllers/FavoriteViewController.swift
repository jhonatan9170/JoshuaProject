//
//  ViewControllerFavorite.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private var myPokemonsFavorite:[PokemonsFavorite]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        obtenerData()
        favoritesTableView.reloadData()
       
    }
    
    
    func obtenerData(){
        let fetchRequest = NSFetchRequest<PokemonsFavorite>(entityName: "PokemonsFavorite")
        do {
            let fetchedData = try context.fetch(fetchRequest)
            myPokemonsFavorite = fetchedData
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
}

extension FavoriteViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPokemonsFavorite?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myPokemonFavoriteCell")
        cell.textLabel?.text = myPokemonsFavorite?[indexPath.row].name
        cell.detailTextLabel?.text = myPokemonsFavorite?[indexPath.row].type
      
        if let imageUrlString = myPokemonsFavorite?[indexPath.row].img, let imageUrl = URL(string: imageUrlString) {
            if let data = try? Data(contentsOf:imageUrl) {
                    // Create Image and Update Image View
                cell.imageView?.image = UIImage(data: data)
            }
        } else {
            let image = UIImage(systemName: "person.crop.circle.fill")
            cell.imageView?.image = image
        }
        
        return cell
    }
    
    
}

extension FavoriteViewController: UITableViewDelegate{
    
}
