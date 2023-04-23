//
//  CollectionViewCellPokemon.swift
//  reto01FW
//
//  Created by user239944 on 4/17/23.
//

import UIKit

class CollectionViewCellPokemon: UICollectionViewCell {

    @IBOutlet weak var viewCellPokemon: UIView!
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var lblNamePokemon: UILabel!
    
    @IBOutlet weak var selectCellPokemon: UIButton!
    
    
    var namePokemon: String?
    
    
    @IBOutlet weak var lblTypePokemon: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectCellPokemon.setTitle("Select", for: .normal
        )
        
        
      
    }

}
