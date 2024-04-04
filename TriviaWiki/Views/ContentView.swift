//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var handler: QuestionDatabase
    
    //for use in temporary button
    @State var buttonPressed = false
    
    var body: some View {
        VStack {
            //temporary button for figuring out loading
            Button(action: {
                print("button pressed")
                print(buttonPressed)
                if !buttonPressed {
                    buttonPressed = true
                    handler.testAdd()
                    //handler.loadSome()
                    Task{ await handler.fillList()}
                }
            }){
                Text(handler.loaded ? "loaded" : "not loaded")
            }
            //temporary loader
            
            Button(action: {
                handler.loadSome()
                print("button hit")
            }){
                Text("view next Question")
            }
            ScrollView {
                ForEach(handler.qViews){x in
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
    ContentView(handler: QuestionDatabase())
}
