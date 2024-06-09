//
//  WebBrowser.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/8/24.
//


import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    public typealias UIViewType = WKWebView
    var urlToDisplay: URL?
    @Binding public var isLoading: Bool
    
    public init(url: String, isLoading: Binding<Bool>) {
        self.urlToDisplay = URL(string: url)
        self._isLoading = isLoading
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        
        if let urlWeb = urlToDisplay {
            let request = URLRequest(url:urlWeb)
            webView.load(request)
        }
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        return webView
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self, isLoading: $isLoading)
    }
    
   
    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        @Binding var isLoading: Bool
        
        public init(_ parent: WebView, isLoading: Binding<Bool>) {
            self._isLoading = isLoading
            self.parent = parent
        }
        
        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading = true
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.isLoading = false
            print("finished loading article")
        }
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}

struct ArticlePage: View {
    let url : String
    @State var loading  : Bool
    var body: some View {
        if loading {
            Text("Loading Wikipedia Article ...")
        }
        WebView(url: url, isLoading: $loading)
    }
}

#Preview {
    ArticlePage(url:"https://edolorenza.medium.com/creating-a-webview-with-progress-bar-in-swiftui-using-webkit-da13be4fc509", loading: false)
}
