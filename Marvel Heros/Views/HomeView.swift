//
//  HomeView.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI

struct HomeView : View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        
        TabView {
            CharacterListView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text ("Characters")
                }.environmentObject(self.homeViewModel)
            ComicListView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text ("Comics")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
