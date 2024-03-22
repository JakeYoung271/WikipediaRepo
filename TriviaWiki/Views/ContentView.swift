//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var qList : DisplayList
    var body: some View {
        ScrollView {
//            ForEach(1..<20){_ in
//                Divider()
//                QuestionDividerView(question: example, items: optionsWrapper(question:example))
//                    .frame(height:650)
//            }
            ForEach(qList.qViews){x in
                x.frame(minHeight : 650)
                Divider()
                    .frame(height:1)
                    .overlay(.gray)
            }
        }
    }
}

#Preview {
    ContentView(qList: DisplayList(l1:[example,example]))
}
