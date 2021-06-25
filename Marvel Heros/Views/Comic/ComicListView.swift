//
//  ComicListView.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/21.
//

import SwiftUI

struct ComicListView: View {
    
    @EnvironmentObject var mainViewModel : MainViewModel
    
    var body: some View {
        
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                if self.mainViewModel.fectchedComics.isEmpty {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .scaleEffect(2)
                        .padding()
                } else {
                    VStack(spacing: 15) {
                        //Displaying Data
                        ForEach(self.mainViewModel.fectchedComics) { comic in
                            ComicCardViewItem(comic: comic)
                        }
                        
                        //Implement infinity scrolling
                        
                        if self.mainViewModel.offeset == self.mainViewModel.fectchedComics.count {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                                .scaleEffect(2)
                                .padding()
                                .onAppear(perform: {
                                    self.mainViewModel.fetchComics()
                                })
                        } else {
                            GeometryReader { geometryReader -> Color in
                                
                                let minY = geometryReader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !self.mainViewModel.fectchedComics.isEmpty && minY < height {
                                    DispatchQueue.main.async {
                                        self.mainViewModel.offeset = self.mainViewModel.fectchedComics.count
                                    }
                                }
                                return Color.clear
                                
                            }.frame(width: 20, height: 20) //END GeometryReader
                        }
                    }.padding(.vertical) //END VStack
                }//END Else
                
            }//END ScrollView
            
        }.onAppear(perform: {
            if self.mainViewModel.fectchedComics.isEmpty {
                self.mainViewModel.fetchComics()
            }
        })// END NavigationView
        
        
    
    }
}

#if DEBUG
struct ComicListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let mainViewModel : MainViewModel = MainViewModel()
        
        ComicListView()
            .environmentObject(mainViewModel)
    }
}
#endif
