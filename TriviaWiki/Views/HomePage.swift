//
//  HomePage.swift
//  TriviaWiki
//
//  Created by Jake Young on 9/13/24.
//

import SwiftUI
import Foundation

struct HomePage : View {
    @Binding var loading : Bool
    @Binding var showHome : Bool
    @State var text  = ""
    let messages = ["finding the hardest questions in the database...","Failing the Turing test...", "Browsing Wikipedia...", "Solving P = NP...", "Getting the elves in your phone \nto write new questions", "Losing in tic tac toe..."]
    @State var timesRan = 0
    func nextString() {
        if text=="" {
            text = messages.randomElement()!
        }
        if timesRan == 25{
            text = "Uh oh this is taking a while. \nTry restarting the app. \nIf the problem persists, \nsend me a problem report..."
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            text = messages.randomElement()!
            timesRan += 1
            nextString()
        }
    }
    var body : some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("WelcomeToWikiQuiz")
                    Spacer()
                }
                VStack{
                    Spacer()
                    if loading {
                        Text("Loading trivia")
                            .font(.title)
                        Text(text)
                            .padding()
                            .onAppear(){
                                nextString()
                            }
                    } else {
                        VStack {
                            NavigationLink (destination: TutorialView().navigationTitle("Tutorial")){
                                Text(" Take Tutorial")
                                    .font(.title)
                                    .padding()
                                    .foregroundStyle(.white)
                                    .background(
                                        Rectangle()
                                            .fill(.blue)
                                            .opacity(0.75)
                                            .cornerRadius(10)
                                    )
                                
                            }
                            Spacer()
                                .frame(height : 40)
                            Button (action: {showHome.toggle(); lightFeedback()}){
                                Text("Start Playing")
                                    .font(.title)
                                    .padding()
                                    .foregroundStyle(.white)
                                    .background(
                                        Rectangle()
                                            .fill(.blue)
                                            .opacity(0.75)
                                            .cornerRadius(10)
                                    )
                                
                            }
                            Spacer()
                                .frame(height: 40)
                        }
                    }
                }
            }
        }
            
    }
}

struct PreviewWrapper: View {
    @State private var demoLoading = false
    @State private var demoShowHome = true
    var body: some View {
        HomePage(loading: $demoLoading, showHome: $demoShowHome)
    }
}

#Preview {
    PreviewWrapper()
}
