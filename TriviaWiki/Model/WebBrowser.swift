//
//  WebBrowser.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/8/24.
//

import SwiftUI
import WebKit

var mylink = "https://www.google.com"

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
    WebView(url:mylink)
}


//struct WebPage {
// 
//    let webPage: WKWebView
//    var urlStr: String
//    
//    init(url:String) {
//        webPage = WKWebView(frame: .zero)
//        urlStr = url
//        webPage.load(URLRequest(url: URL(string: urlStr)!))
//    }
//}
//
//struct repWebPage: UIViewRepresentable {
//    
//    let mwebpage: WebPage
//       
//    init(webpage:WebPage) {
//           mwebpage = webpage
//
//       }
//       
//       func makeUIView(context: Context) -> WKWebView {
//           return mwebpage.webPage
//       }
//       func updateUIView(_ uiView: WKWebView, context: Context) {
//           //webView.load(URLRequest(url: URL(string: urlStr)!))
//           //mwebpage.update()
//       }
//   }
