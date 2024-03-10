//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            ForEach(1..<20){_ in
                testQuestionView(question: example, items: optionsWrapper(question:example))
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
