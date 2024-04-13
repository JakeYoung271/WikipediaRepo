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
    @State var IDList : [Int]
    @State var counter: Int
    
    init(){
        counter = 1
        IDList = [Int]()
    }
    
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(IDList, id: \.self){x in
                        QuestionDividerView(q: Question(id1:x))
                        Divider()
                            .frame(height:1)
                            .overlay(.gray)
                    }
                    loadingView()
                        .padding()
                        .onAppear{
                            print("in content view: adding question \(counter)")
                                IDList.append(qRec.pub.recommend())
                                IDList.append(qRec.pub.recommend())
                                IDList.append(qRec.pub.recommend())
                        }
                        .onDisappear{
                            print("loader disappeared")
                        }
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
