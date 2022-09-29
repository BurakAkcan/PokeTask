//
//  Pokemon.swift
//  PokeTask
//
//  Created by Burak AKCAN on 21.09.2022.
//

import Foundation

struct PokemonPage:Codable{
    
    let results:[Pokemon]
    
    enum CodingKeys:String,CodingKey{
        case results
    }
}
