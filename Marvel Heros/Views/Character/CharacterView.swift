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
    @State var isTapped = false
    
    var body: some View {
        
        if homeViewModel.isCharacterDataLoading {
        
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2)
            
        } else {
            GeometryReader { geometry in
                
                NavigationView {
                
                    ScrollView(.vertical, showsIndicators:false, content : {
                        
                        if let characters = self.homeViewModel.fectchedCharacters {
                            if characters.isEmpty {
                                Text("No Results Found")
                                    .padding(.top,20)
                            } else {
                                ForEach(characters) { data in
                                    CharacterCardViewItem(character: data, geoProxy:geometry,isTapped: isTapped)
                                        
                                }
                            }
                        }
                        
                    }).navigationBarTitle(isTapped ? "Back" : "Marvel Heros")
                }
            }
        }
        


    }
}

struct CharacterCardViewItem: View {
    
    var character: Character
    var geoProxy: GeometryProxy
    @State var isTapped = false
    
    var body: some View {
        VStack(spacing: 10, content: {
            
            NavigationLink(
                destination:
                    
                    Text("\(self.character.name)")
                    .navigationBarTitle(self.character.name).onAppear() {
                        self.isTapped.toggle()
                    }
                
                ,label: {
                    WebImage(url: AppConstants.extractImage(data: self.character.thumbnail))
                        .resizable()
                        .placeholder(Image(systemName: "photo"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: self.geoProxy.size.width, height: 250)
                        .cornerRadius(8)
                })
        
            VStack(alignment: .center, content: {
                Text(character.name)
                    .font(.system(size: 18))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
//                Text(character.description)
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                    .lineLimit(4)
//                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                
                //Links
//                VStack(spacing: 5) {
//
//                    ForEach(self.character.urls, id: \.self) { data in
//
//                        let link = AppConstants.exctractURL(data: data)
//                        let urlType = AppConstants.exctractURLType(data: data)
//
//                        NavigationLink(
//                            destination: WebView(url: link)
//                                .navigationBarTitle(urlType),
//                            label: {
//                                Text(urlType)
//                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                            })
//                    }
//                }
                
            })
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
        }).padding(.horizontal)
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
        Divider()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
