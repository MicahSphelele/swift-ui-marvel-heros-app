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
}
