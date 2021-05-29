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
            
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .green))
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

struct CharacterCardViewItem: View {
    
    var character: Character
    var geometryProxy: GeometryProxy
    
    var body: some View {
        VStack(spacing: 10, content: {
            
            NavigationLink(
                destination:
                    
                    SingleCharacterView(character: self.character, geometryProxy: self.geometryProxy)
                    .navigationBarTitle(self.character.name)
                
                ,label: {
                    WebImage(url: AppConstants.extractImage(data: self.character.thumbnail))
                        .resizable()
                        .placeholder(Image(systemName: "photo"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: self.geometryProxy.size.width - 25, height: 250)
                        .cornerRadius(8)
                })
        
            VStack(alignment: .center, content: {
                Text(character.name)
                    .font(.system(size: 18))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            })
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
        }).padding(.horizontal)
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
        Divider()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
