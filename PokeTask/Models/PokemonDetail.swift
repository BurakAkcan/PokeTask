//
//  PokemonDetail.swift
//  PokeTask
//
//  Created by Burak AKCAN on 21.09.2022.
//

import Foundation

struct PokemonDetail:Codable{
    let id:Int
    let name:String
    let baseExperience:Int
    let weight:Int
    let height:Int
    let stats:[PokemonStat]
    
    enum CodingKeys:String,CodingKey{
        case id
        case name
        case baseExperience = "base_experience"
        case weight
        case height
        case stats  
    }
}
typealias PokemonDetails = [PokemonDetail]

