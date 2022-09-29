//
//  PokemonDetail.swift
//  PokeTask
//
//  Created by Burak AKCAN on 21.09.2022.
//

import Foundation

struct Pokemon:Codable{
    let name : String
    var id  : String?
    let url:String
    
    init(name: String = "", id: Int = 0,url:String) {
            self.name = name
            self.id = String(describing: id)
        self.url = url
        }
    
}
