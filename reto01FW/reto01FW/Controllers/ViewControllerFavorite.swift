//
//  ViewControllerFavorite.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit
import CoreData

class ViewControllerFavorite: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private var myPokemonsFavorite:[PokemonsFavorite]?
    
    @IBOutlet weak var favoritesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("recarga")
        obtenerData()
        print("recarga2")
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

extension ViewControllerFavorite:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myPokemonsFavorite?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "myPokemonFavoriteCell")
        cell.textLabel?.text = myPokemonsFavorite?[indexPath.row].name
            
        return cell
    }
    
    
}

extension ViewControllerFavorite: UITableViewDelegate{
    
}
