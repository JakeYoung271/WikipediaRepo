//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var qList : DisplayList
    @State var buttonPressed = false
    var body: some View {
        VStack {
            Button(action: {
                buttonPressed.toggle()
                let qIndex = Int.random(in:0...279)
                let newQuestion = Question()
                qList.add(q:newQuestion)
            }){
                Text(buttonPressed ? "false" : "true")
            }
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
}

#Preview {
    ContentView(qList: DisplayList(l1:[example,example]))
}
