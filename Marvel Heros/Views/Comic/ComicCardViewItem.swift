//
//  ComicCardItem.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/06/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicCardViewItem: View {
    
    var comic: Comic
    
    var body: some View {
        VStack(spacing: 10, content: {
            
            NavigationLink(
                destination:
                    Text("This is \(comic.title)")
                , label: {
                    WebImage(url: AppConstants.extractImage(data: self.comic.thumbnail))
                        .resizable()
                        .placeholder(Image(systemName: "photo"))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 315, height: 250)
                        .cornerRadius(8)
                        .padding(.trailing,20)
                        .padding(.leading,20)
                })
                .onTapGesture {
                    print("Tapped Comic")
                }
        
            VStack(alignment: .center, content: {
                Text(comic.title)
                    .font(.system(size: 18))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                
            })
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
        }).padding(.horizontal)
        .shadow(color: Color.black.opacity(0.3), radius: 3, x: 3, y: 3)
        Divider()
    }
}

#if DEBUG
struct ComicCardViewItem_Previews: PreviewProvider {
    
    static var previews: some View {
    
            ComicCardViewItem(comic: Comic(id: 1, title: "Marvel Age Spider-Man Vol. 2: Everyday Hero (Digest)", description: "", thumbnail: ["path": "http://i.annihil.us/u/prod/marvel/i/mg/9/20/4bc665483c3aa","extension": "jpg"], urls: [["type" : "detail","url" : "http://marvel.com/comics/collection/1308/marvel_age_spider-man_vol_2_everyday_hero_digest?utm_campaign=apiRef&utm_source=0d82abc8a51e71632327a4e415e734d1"]]))
        
    }
}
#endif
