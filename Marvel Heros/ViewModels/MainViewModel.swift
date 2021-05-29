//
//  MainViewModel.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI
import Combine

class MainViewModel : ObservableObject {
    
    @AppStorage("isDarkMode") var isDarkMode = false
    
    //Used to cancel the search publisher whenever we need
    var searchaCancellable : AnyCancellable? = nil
    
    //Combine Framework searchbar
    @Published var searchQuery = "batman"
    
    //Fetched characters data
    @Published var fectchedCharacters : [Character]? = nil
    
    //Fetched comic data
    @Published var fectchedComics : [Comic] = []
    
    @Published var offeset: Int = 0
    
    @Published var isCharacterDataLoading = true
    
    @Published var isErrorEncountered = false

    init() {
        print("init HomeViewModel")
        self.searchaCancellable = $searchQuery
            .removeDuplicates() // Removing duplicate typings
            .debounce(for: 0.4, scheduler: RunLoop.main) // We need to fetch for every typing, it will wait for 0.4 after user ends typing
            .sink(receiveValue: { stringValue in
                
                if stringValue == "" {
                    print("Search string is empty")
                    self.fectchedCharacters = nil
                } else {
                    print("Try an fetch/search characters")
                    self.fectchedCharacters = nil
                    //self.fetchCharacters()
                }
            })
    }
    
    func fetchCharacters() {
        let timeStamp = String(Date().timeIntervalSince1970)
        //let hash =  AppConstants.MD5(data: "\(timeStamp)\(AppConstants.PRIVATE_KEY)\(AppConstants.PUBLIC_KEY)")
        //let originalQuery = self.searchQuery.replacingOccurrences(of: " ", with: "%20")
        let apiUrl = "https://gateway.marvel.com:443/v1/public/characters?limit=20&apikey=\(AppConstants.PUBLIC_KEY)&ts=\(timeStamp)&hash=\(self.getApiHash(timeStamp: timeStamp))"
        let session = URLSession.shared
        
        let url = URL(string: apiUrl)
        
        if url == nil {
            print("URL is nil")
            self.isCharacterDataLoading = false
            self.isErrorEncountered = true
            return
        }
        
        session.dataTask(with: url! ) { (data, response, err) in
            
            
            if let error = err {
                print("Error = \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.isCharacterDataLoading = false
                    self.isErrorEncountered = true
                }
                return
            }
            
            guard let apiData = data else {
                print("No character data found")
                self.isCharacterDataLoading = false
                self.isErrorEncountered = true
                return
            }
            
            do {
                let characters = try JSONDecoder().decode(CharacterResults.self, from: apiData)

                DispatchQueue.main.async {
                    if self.fectchedCharacters == nil {
                        self.isCharacterDataLoading = false;
                        self.isErrorEncountered = false
                        self.fectchedCharacters = characters.data.results
                    }
                }
            } catch {
                print("Exception error : \(error as Any) ")
                self.isCharacterDataLoading = false
                self.isErrorEncountered = true
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
