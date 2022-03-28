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
    @Published var fectchedCharacters : [Character] = []
    
    //Fetched comic data
    @Published var fectchedComics : [Comic] = []
    
    @Published var offeset: Int = 0
    
    @Published var isCharacterDataLoading = true
    
    @Published var isErrorEncountered = false
    
    @Published var isAlertPresented = false

    init() {
        print("init HomeViewModel")
        self.searchaCancellable = $searchQuery
            .removeDuplicates() // Removing duplicate typings
            .debounce(for: 0.4, scheduler: RunLoop.main) // We need to fetch for every typing, it will wait for 0.4 after user ends typing
            .sink(receiveValue: { stringValue in
                
                if stringValue == "" {
                    print("Search string is empty")
                } else {
                    print("Try an fetch/search characters")
                }
            })
    }
    
    func fetchCharacters() {
        let timeStamp = String(Date().timeIntervalSince1970)
        let apiUrl = "https://gateway.marvel.com:443/v1/public/characters?limit=30&apikey=\(AppConstants.PUBLIC_KEY)&ts=\(timeStamp)&hash=\(self.getApiHash(timeStamp: timeStamp))"
        let url = URL(string: apiUrl)
        
        URLSession.shared.request(url: url, expecting: CharacterResults.self) { [weak self] result in
            
            switch result {
            case .success(let characters) :
                self?.fectchedCharacters.append(contentsOf: characters.data.results)
                self?.isCharacterDataLoading = false;
            case .failure(let error) :
                self?.isAlertPresented = true
                self?.isErrorEncountered = true
                self?.isCharacterDataLoading = false
                print("Error getting comics: \(error)")
            }
            
        }
    }
    
    func fetchComics() {
        let timeStamp = String(Date().timeIntervalSince1970)
        let apiUrl = "https://gateway.marvel.com:443/v1/public/comics?limit=20&offset=\(self.offeset)&ts=\(timeStamp)&apikey=\(AppConstants.PUBLIC_KEY)&hash=\(self.getApiHash(timeStamp: timeStamp))"
        
        let url = URL(string: apiUrl)
        
        self.isErrorEncountered = false
        self.isAlertPresented = false
        
        URLSession.shared.request(url: url, expecting: ComicResults.self) { [weak self] result in
            
            switch result {
            case .success(let comics) :
                self?.fectchedComics.append(contentsOf: comics.data.results)
            case .failure(let error) :
                self?.isAlertPresented = true
                print("Error getting comics: \(error)")
            }
            
        }
    }
    
   private func getApiHash(timeStamp: String) -> String {
        return AppConstants.MD5(data: "\(timeStamp)\(AppConstants.PRIVATE_KEY)\(AppConstants.PUBLIC_KEY)")
    }
}
