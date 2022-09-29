//
//  PokemonStat.swift
//  PokeTask
//
//  Created by Burak AKCAN on 21.09.2022.
//

import Foundation

struct PokemonStat: Codable {
    let name:String
    let value:Int
    
    enum ContainerKeys: String, CodingKey {
        case value = "base_stat"
        case stat
    }
    
    enum StatKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        let statContainer = try container.nestedContainer(keyedBy: StatKeys.self, forKey: .stat)
        
        self.name = try statContainer.decode(String.self, forKey: .name)
        self.value = try container.decode(Int.self, forKey: .value)
    }
    
}
