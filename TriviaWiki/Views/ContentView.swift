//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var loadingCurrRatings = true
    
    var body: some View {
        ZStack{
            if loadingCurrRatings {
                Text("Currently Loading your app!")
            } else {
                BrowsePage()
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
