//
//  WebView.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2021/05/09.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    var url : URL
    
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: self.url))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}
