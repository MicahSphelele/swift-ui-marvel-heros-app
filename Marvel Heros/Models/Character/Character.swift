//
//  Character.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI

struct Character : Identifiable, Codable {
    var id : Int
    var name: String
    var modified: String
    var description: String
    var thumbnail: [String : String]
    var urls: [[String : String]]
}
