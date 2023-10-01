//
//  Creature.swift
//  CatchPokemon
//
//  Created by apple on 25.09.2023.
//

import Foundation

struct Creature: Codable, Identifiable {
    let id = UUID().uuidString
    var name: String
    var url: String     //url for getail on Pokemon
    
    enum CodingKeys: CodingKey {
        case name, url
    }
}
