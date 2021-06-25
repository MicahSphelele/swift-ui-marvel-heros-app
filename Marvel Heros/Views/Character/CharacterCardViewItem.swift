//
//  CharacterCardViewItem.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/06/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterCardViewItem: View {
    
    var character: Character
    var geometryProxy: GeometryProxy
    
    var body: some View {
        VStack(spacing: 10, content: {
            
            NavigationLink(
                destination:
                    
                    SingleCharacterView(character: self.character, geometryProxy: self.geometryProxy)
                
                ,label: {
                    WebImage(url: AppConstants.extractImage(data: self.character.thumbnail))
                        .resizable()
                        .placeholder(Image(systemName: "photo"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: self.geometryProxy.size.width - 25, height: 250)
                        .cornerRadius(8)
                }).onTapGesture {
                    print("Tapped Character")
                }
        
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

#if DEBUG
struct CharacterCardViewItem_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometryReader in
        
            let character = Character(id: 1011334, name: "3-D Man", modified: "2014-04-29T14:18:17-0400", description: "This is a description", thumbnail: ["path": "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784","extension": "jpg"], urls: [["type" : "detail","url" : "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=0d82abc8a51e71632327a4e415e734d1"], ["type" : "wiki","url" :"http://marvel.com/universe/3-D_Man_(Chandler)?utm_campaign=apiRef&utm_source=0d82abc8a51e71632327a4e415e734d1"], ["type" : "comiclink","url" :"http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=0d82abc8a51e71632327a4e415e734d1"]])
            
            CharacterCardViewItem(character: character,
                                  geometryProxy: geometryReader)
        }
        
    }
}
#endif
