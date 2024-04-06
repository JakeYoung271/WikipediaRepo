//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI



struct loadingView: View {
    var body: some View {
        Text("Questions are loading")
            .font(.title)
        Text("If this message is not going away, check your internet connection or go to your profile tab to report an issue")
    }
}

struct ContentView: View {
    @ObservedObject var handler: qHandler
    let data : qDatabase
    //for use in temporary button
    @State var counter: Int
    
    init(){
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
                    loadingView()
                        .padding()
                        .onAppear{
                            for i in 1...2{
                                print("adding question \(counter)")
                                handler.addQ(id:counter)
                                counter += 1
                            }
                        }
                        .onDisappear{
                            print("loader disappeared")
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
    ContentView()
}
