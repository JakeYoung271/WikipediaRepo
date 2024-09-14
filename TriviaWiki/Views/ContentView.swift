//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

func lightFeedback() {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
}

struct ContentView: View {
    @State private var loadingCurrRatings = true
    @State private var showHomePage = true
    
    var body: some View {
        ZStack{
            if showHomePage {
                HomePage(loading: $loadingCurrRatings, showHome: $showHomePage)
            } else {
                BrowsePage(homeVar: $showHomePage)
            }
        }
        .onAppear{
            loadData()
            loadingTimeout(seconds: 10)
        }
    }
    
    func loadData(){
        Task {
            await fbase.pub.getRatingsDoc()
            if loadingCurrRatings {
                loadingCurrRatings = false
            }
        }
    }
    
    func loadingTimeout(seconds: Int) {
        Task {
            try await Task.sleep(nanoseconds: UInt64(seconds) * 1_000_000_000)
            if loadingCurrRatings {
                loadingCurrRatings = false
            }
        }
    }
}
