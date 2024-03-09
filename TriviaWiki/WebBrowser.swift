//
//  WebBrowser.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/8/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
 
    let webView: WKWebView
    var urlStr: String
    
    init(url:String) {
        webView = WKWebView(frame: .zero)
      urlStr = url
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        webView.load(URLRequest(url: URL(string: urlStr)!))
    }
}

#Preview {
    WebView(url : "https://google.com")
}
