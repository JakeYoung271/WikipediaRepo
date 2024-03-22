//
//  TriviaWikiApp.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

@main
struct TriviaWikiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(qList: DisplayList(l1:[example,example]))
        }
    }
}
