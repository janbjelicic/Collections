//
//  Character.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import Foundation

enum CharacterRace: String, Decodable {
    case human = "Human"
    case eagle = "Eagle"
    case elf = "Elf"
}

struct Character: Decodable {
    let name: String
    let race: CharacterRace
}
