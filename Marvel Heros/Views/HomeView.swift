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
            CharacterView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text ("Characters")
                }.environmentObject(self.homeViewModel)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
