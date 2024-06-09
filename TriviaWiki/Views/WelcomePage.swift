//
//  WelcomePage.swift
//  TriviaWiki
//
//  Created by Jake Young on 6/5/24.
//

import SwiftUI

import Foundation

class UserDefaultsManager {
    private let tutorialShownKey = "tutorialShown"
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: tutorialShownKey)
        }
        set {
            UserDefaults.standard.set(!newValue, forKey: tutorialShownKey)
        }
    }
}


struct WelcomePage: View {
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
    var body: some View {
        ZStack {
            VStack{
                Image("WelcomeFrame")
                Spacer()
            }
            VStack {
                Spacer()
                if UserDefaultsManager.shared.isFirstLaunch {
                    VStack {
                        Button(action: {
                            UserDefaultsManager.shared.isFirstLaunch = false
                            Globals.shared.firstTime = false
                            Globals.shared.showTutorial = true}){
                            Text("Learn to Play")
                                .font(.title2)
                                .padding()
                                .foregroundStyle(.white)
                                .background(
                                    Rectangle()
                                        .fill(.blue)
                                        .opacity(0.75)
                                        .cornerRadius(10)
                                )
                        }
                        .padding()
                        Button(action: {
                            UserDefaultsManager.shared.isFirstLaunch = false
                            Globals.shared.firstTime = false
                            Globals.shared.showTutorial = false}){
                            Text("Skip Tutorial ")
                                .font(.title2)
                                .padding()
                                .foregroundStyle(.white)
                                .background(
                                    Rectangle()
                                        .fill(.blue)
                                        .opacity(0.75)
                                        .cornerRadius(10)
                                )
                        }
                    }
                } else {
                    Text("Loading trivia")
                        .font(.title)
                    Text(text)
                        .padding()
                        .onAppear(){
                            nextString()
                        }
                    
                }
                Spacer().frame(height: 30)
            }
        }
    }
}

#Preview {
    WelcomePage()
}
