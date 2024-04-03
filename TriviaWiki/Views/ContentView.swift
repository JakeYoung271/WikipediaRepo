//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var handler: QuestionDatabase
    @ObservedObject var qList : DisplayList
    @State var buttonPressed = false
    var body: some View {
        VStack {
            Button(action: {
                buttonPressed.toggle()
                let qIndex = Int.random(in:0...279)
                let newQuestion = Question()
                handler.toDisplay.add(q:newQuestion)
                Task{ await handler.fillList()}
            }){
                Text(buttonPressed ? "false" : "true")
            }
            ScrollView {
    //            ForEach(1..<20){_ in
    //                Divider()
    //                QuestionDividerView(question: example, items: optionsWrapper(question:example))
    //                    .frame(height:650)
    //            }
                ForEach(handler.toDisplay.qViews){x in
                    x.frame(minHeight : 650)
                    Divider()
                        .frame(height:1)
                        .overlay(.gray)
                }
            }
        }
    }
}

#Preview {
    ContentView(handler: QuestionDatabase(),
                qList: DisplayList(l1:[example,example]))
}
