//
//  Constants .swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI
import CryptoKit

class AppConstants {
    
   static let PUBLIC_KEY = ""
   static let PRIVATE_KEY = ""
   
   static func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
    static func extractImage(data: [String:String]) -> URL {
     
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        
        return URL(string: "\(path).\(ext)")!
    }
    
    static func exctractURL(data: [String:String]) -> URL {
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    static func exctractURLType(data: [String:String]) -> String {
        let type = data["type"] ?? ""
        
        return type.capitalized
    }
    
}
