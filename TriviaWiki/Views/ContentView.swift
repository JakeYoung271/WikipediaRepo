//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var handler: qHandler
    let data : qDatabase
    //for use in temporary button
    @State var counter: Int
    
    init(handler: QuestionDatabase){
        data = qDatabase()
        for i in 1...30{
            let quest = Question(id1: i, topic: "TestQ", q: "This is question \(i)", opts: ["1","2","3","4"], resps: [0,0,0,0], corr: 0, cat: "Mathematics", diff: 1)
            data.addToQuestions(q: quest)
        }
        self.handler = qHandler()
        //for use in temporary button
        counter = 1
    }
    
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(handler.displayIDs, id: \.self){x in
                        QuestionDividerView(q: data.getQ(id: x))
                        Divider()
                            .frame(height:1)
                            .overlay(.gray)
                    }
                    
                }
            }
            Button(action: {
                handler.addQ(id:counter)
                counter += 1
                print("loader")
            }){
                Text("addQuestion")
            }
        }
    }
}

#Preview {
    ContentView(handler: QuestionDatabase())
}
