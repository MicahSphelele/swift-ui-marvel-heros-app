//
//  SingleCharacterView.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/29.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleCharacterView: View {
    
    var character : Character
    var geometryProxy: GeometryProxy
    
    var body: some View {
        ScrollView(.vertical, showsIndicators:false, content : {
            
            HStack(alignment: .center, content: {
                WebImage(url: AppConstants.extractImage(data: self.character.thumbnail))
                    .resizable()
                    .placeholder(Image(systemName: "photo"))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: self.geometryProxy.size.width, height: 480,alignment: .center)
            })
            
            VStack {
                Text(self.character.name)
                    .font(.system(size: 35,weight: .bold))
                    .foregroundColor(.green)
                
                Text(self.character.description == "" ? "This character does not have a description"
                        : self.character.description)
                    .padding()
                    .font(.caption)
                    .foregroundColor(.green)
                
                Text(self.character.modified == "" ? "Modified date not found"
                        : AppConstants.convertDate(stringDate: self.character.modified))
                    .padding()
                    .font(.caption)
                    .foregroundColor(.green)
                
                Spacer()
                
                VStack {
                    ForEach(self.character.urls, id: \.self) { url in
                        
                        let link = AppConstants.exctractURL(data: url)
                        let linkType = AppConstants.exctractURLType(data: url)
                    
                        NavigationLink(
                            destination: WebView(url: link)
                                .navigationBarTitle(linkType),
                            label: {
                                Text(linkType)
                                    .frame(width: 280, height: 50,alignment: .center)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                
                            }).cornerRadius(10)
                            
                        Spacer()
                    
                    }
                }
            }
            
        }).navigationTitle("")
        .toolbar(content: {
            ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                
                let link =  URL(string: character.urls[0]["url"] ?? "")!
                
                let linkType = character.urls[0]["type"]?.capitalized
                
                if(linkType == "Detail") {
                    NavigationLink(
                        destination: WebView(url: link),
                        label: {
                            Label("Mode", systemImage: "info.circle.fill")
                                .labelStyle(IconOnlyLabelStyle())
                        })
                }
            }
        })
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

#if DEBUG
struct SingleCharacterView_Previews: PreviewProvider {

    static var previews: some View {

        GeometryReader { geometryReader in
            
            let character = Character(id: 1011334, name: "3-D Man", modified: "2014-04-29T14:18:17-0400", description: "This is a description", thumbnail: ["path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784","extension": "jpg"], urls: [["type" : "detail","url" : "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=0d82abc8a51e71632327a4e415e734d1"], ["type" : "wiki","url" :"http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=0d82abc8a51e71632327a4e415e734d1"], ["type" : "comiclink","url" :"http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=0d82abc8a51e71632327a4e415e734d1"]])
            
            SingleCharacterView(character: character, geometryProxy: geometryReader).toolbar(content: {
                ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    
                    let link =  URL(string: character.urls[0]["url"] ?? "")!
                    
                    let linkType = character.urls[0]["type"]?.capitalized
                    
                    if(linkType == "Detail") {
                        NavigationLink(
                            destination: WebView(url: link),
                            label: {
                                Label("Mode", systemImage: "info.circle.fill")
                                    .labelStyle(IconOnlyLabelStyle())
                            })
                    }
                }
            })
        }
    }
}
#endif
