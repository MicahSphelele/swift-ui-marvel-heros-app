//
//  Comic.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI

struct Comic: Identifiable, Codable {
    
    var id : Int
    var title: String
    var description: String?
    var thumbnail: [String:String]
    var urls: [[String:String]]
    
}
