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
                
                Text(self.character.description)
                    .foregroundColor(.green)
            }
            
        }).navigationTitle("")
        .toolbar(content: {
            ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button {
                   
                    } label: {
                        Label("Mode", systemImage: "info.circle.fill")
                            .labelStyle(IconOnlyLabelStyle())
                    }
                }
        })
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct SingleCharacterView_Previews: PreviewProvider {

    static var previews: some View {

        //SingleCharacterView(character: character)
        MainView()
    }
}
