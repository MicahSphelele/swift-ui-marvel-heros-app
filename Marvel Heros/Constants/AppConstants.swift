//
//  Constants .swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI
import CryptoKit

class AppConstants {
    
   static let PUBLIC_KEY = "0d82abc8a51e71632327a4e415e734d1"
   static let PRIVATE_KEY = "006779b222b68e9f5643ee83df57d92fd4586be7"
   
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
