//
//  SingleCharacterView.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/29.
//

import SwiftUI

struct SingleCharacterView: View {
    
    var character : Character
    
    var body: some View {
        Text("Hello : \(character.name)")
    }
}

struct SingleCharacterView_Previews: PreviewProvider {
    let character = Character(id: 1, name: "Sphelele", description: "This is a description", thumbnail: ["":""], urls: [["":""]])
  
    static var previews: some View {

        //SingleCharacterView(character: character)
        MainView()
    }
}
