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
                Divider()
                QuestionDividerView(question: example, items: optionsWrapper(question:example))
                    .frame(height:650)
            }
        }
    }
}

#Preview {
    ContentView()
}
