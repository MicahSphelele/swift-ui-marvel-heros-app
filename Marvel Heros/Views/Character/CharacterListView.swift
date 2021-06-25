//
//  CharacterView.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterListView: View {
    
    @EnvironmentObject var mainViewModel : MainViewModel
    @State var isPresented = true
    @State var isDataReloaded = false
    
    var body: some View {
        
        ZStack {
            if mainViewModel.isCharacterDataLoading {
            
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .scaleEffect(2)
                
            } else {
            
                GeometryReader { geometry in
                    
                    ScrollView(.vertical, showsIndicators:false, content : {
                        
                        if let characters = self.mainViewModel.fectchedCharacters {
                            if characters.isEmpty {
                                Text("No Results Found")
                                    .padding(.top,20)
                            } else {
                                ForEach(characters) { data in
                                    CharacterCardViewItem(character: data, geometryProxy:geometry)
                                }
                            }
                        }
                        
                        if(self.mainViewModel.isErrorEncountered) {
                            Text("")
                                .alert(isPresented: $isPresented) {
                                    Alert(title: Text("Error Encountered"), message: Text("Check internet connection"), dismissButton: .default(Text("Got it!")))
                                }
                        }
                        
                    })
                }
            }
        }.onAppear {
            //mainViewModel.isCharacterDataLoading = true
            //mainViewModel.fectchedCharacters = nil
            mainViewModel.fetchCharacters()
            
        } // ZStack END

    }
}

#if DEBUG
struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        
        let mainViewModel : MainViewModel = MainViewModel()
        
        CharacterListView()
            .environmentObject(mainViewModel)
    }
}
#endif
