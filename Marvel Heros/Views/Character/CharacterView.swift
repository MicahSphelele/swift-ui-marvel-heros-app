//
//  CharacterView.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/08.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterView: View {
    
    @EnvironmentObject var homeViewModel : HomeViewModel
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical,showsIndicators:false,content : {
                VStack(spacing: 15) {
                    HStack(spacing: 10){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Character",text : $homeViewModel.searchQuery)
                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                            .disableAutocorrection(true)
                    }.padding(.vertical,10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }.padding()
                
                if let characters = self.homeViewModel.fectchedCharacters {
                    if characters.isEmpty {
                        Text("No Results Found")
                            .padding(.top,20)
                    } else {
                        ForEach(characters) { data in
                            CharacterRowView(character: data)
                        }
                    }
                }
                
            })
            .navigationBarTitle("Marvel Heros")
        }
    }
}

struct CharacterRowView: View {
    
    var character: Character
    
    //print("Image = \(imageUrl)")
    
    var body: some View {
        HStack(alignment: .top, spacing: 15, content: {
            
            
            WebImage(url: AppConstants.extractImage(data: self.character.thumbnail))
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text(character.name)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Text(character.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(4)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                
                //Links
                VStack(spacing: 5) {
                
                    ForEach(self.character.urls, id: \.self) { data in
                        
                        let link = AppConstants.exctractURL(data: data)
                        let urlType = AppConstants.exctractURLType(data: data)
                        
                        NavigationLink(
                            destination: WebView(url: link)
                                .navigationBarTitle(urlType),
                            label: {
                                Text(urlType)
                            })
                    }
                }
                
            })
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
        }).padding(.horizontal)
        Divider()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
