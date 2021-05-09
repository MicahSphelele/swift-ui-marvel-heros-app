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
    @Published var searchQuery = "batman"
    
    //Fetched characters data
    @Published var fectchedCharacters : [Character]? = nil
    
    //Fetched comic data
    @Published var fectchedComics : [Comic] = []
    
    @Published var offeset: Int = 0
    
    
    init() {
        print("init()")
        self.searchaCancellable = $searchQuery
            .removeDuplicates() // Removing duplicate typings
            .debounce(for: 0.4, scheduler: RunLoop.main) // We need to fetch for every typing, it will wait for 0.4 after user ends typing
            .sink(receiveValue: { stringValue in
                
                if stringValue == "" {
                    print("stringValue == \"\"")
                    self.fectchedCharacters = nil
                } else {
                    print("else searchCharacters()")
                    self.fectchedCharacters = nil
                    self.searchCharacters()
                }
            })
    }
    
    func searchCharacters() {
        let timeStamp = String(Date().timeIntervalSince1970)
        //let hash =  AppConstants.MD5(data: "\(timeStamp)\(AppConstants.PRIVATE_KEY)\(AppConstants.PUBLIC_KEY)")
        //let originalQuery = self.searchQuery.replacingOccurrences(of: " ", with: "%20")
        let apiUrl = "https://gateway.marvel.com:443/v1/public/characters?limit=1&apikey=\(AppConstants.PUBLIC_KEY)&ts=\(timeStamp)&hash=\(self.getApiHash(timeStamp: timeStamp))"
        print(apiUrl)
        let session = URLSession.shared
        
        let url = URL(string: apiUrl)
        //0d82abc8a51e71632327a4e415e734d1
        if url == nil {
            print("URL is nil")
            return
        }
        
        session.dataTask(with: url! ) { (data, response, err) in
            
            //print("Response \(data)")
            
            if let error = err {
                print("Error = \(error.localizedDescription)")
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
                print("Error 2 = \(error as Any) ")
            }
            
        }.resume()
    }
    
    func fetchComics() {
        let timeStamp = String(Date().timeIntervalSince1970)
        let apiUrl = "http://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(self.offeset)&ts=\(timeStamp)&apiKey=\(AppConstants.PUBLIC_KEY)&hash\(self.getApiHash(timeStamp: timeStamp))"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: apiUrl)!) { (data, _, err) in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let apiData = data else {
                print("No comic data found")
                return
            }
            
            do {
                let comics = try JSONDecoder().decode(ComicResults.self, from: apiData)
                
                DispatchQueue.main.async {
                    
                    self.fectchedComics.append(contentsOf: comics.data.results)
                  
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
   private func getApiHash(timeStamp: String) -> String {
        
        return AppConstants.MD5(data: "\(timeStamp)\(AppConstants.PRIVATE_KEY)\(AppConstants.PUBLIC_KEY)")
    }
}
