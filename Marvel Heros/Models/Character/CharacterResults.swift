//
//  CharacterResults.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI

struct CharacterResults: Codable{
    
    var code: Int
    var status: String
    var data : CharacterData
}
