//
//  HomeViewModel.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI
import CryptoKit
import Combine

class HomeViewModel : ObservableObject {
    
    //Used to cancel the search publisher whenever we need
    var searchaCancellable : AnyCancellable? = nil
    
    //Combine Framework searchbar
    @Published var searchQuery = ""
    
    //Fetched characters data
    @Published var fectchedCharacters : [Character]? = nil
    
    //Fetched comic data
    @Published var fectchedComics : [Comic] = []
    
    @Published var offeset: Int = 0
    
    
    init() {
        self.searchaCancellable = $searchQuery
            .removeDuplicates() // Removing duplicate typings
            .debounce(for: 0.4, scheduler: RunLoop.main) // We need to fetch for every typing, it will wait for 0.4 after user ends typing
            .sink(receiveValue: { stringValue in
                
                if stringValue == "" {
                    self.fectchedCharacters = nil
                } else {
                    self.fectchedCharacters = nil
                    self.searchCharacters()
                }
            })
    }
    
    func searchCharacters() {
        let timeStamp = String(Date().timeIntervalSince1970)
        let hash =  AppConstants.MD5(data: "\(timeStamp)\(AppConstants.PRIVATE_KEY)\(AppConstants.PUBLIC_KEY)")
        let originalQuery = self.searchQuery.replacingOccurrences(of: " ", with: "%20")
        let apiUrl = "http://gateway.marvel.com:443/v1/public/characters?nameStartsWith = \(originalQuery)&ts=\(timeStamp)&apiKey=\(AppConstants.PUBLIC_KEY)&hash\(hash)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: apiUrl)!) { (data, _, err) in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let apiData = data else {
                print("No character data found")
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(CharacterResults.self, from: apiData)
                
                DispatchQueue.main.async {
                    if self.fectchedCharacters == nil {
                        self.fectchedCharacters = characters.data.results
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
