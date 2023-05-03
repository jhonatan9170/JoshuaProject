//
//  PokemonModel.swift
//  reto01FW
//
//  Created by Joshua Sosa cruz on 21/04/23.
//

import Foundation

class Pokemon {
    var name : String
    var type : String
    var img : String
    var hp : Int
    var attack : Int
    var defense : Int
    var weight : Int
    var height : Int
    
    init(name:String,type:String,img:String,hp:Int,attack:Int,defense:Int,weight:Int,height:Int){
        self.name = name
        self.type = type
        self.img = img
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.weight = weight
        self.height = height
    }
    
}
