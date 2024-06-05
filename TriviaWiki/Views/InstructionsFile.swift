//
//  InstructionsFile.swift
//  TriviaWiki
//
//  Created by Jake Young on 6/4/24.
//

import SwiftUI

let wikipediaQuote = "The English Wikipedia, with its 6.8 million articles, is the largest of the editions, which together comprise more than 63 million articles and attract more than 1.5 billion unique device visits and 13 million edits per month"

class demoQuestion : Question {
    override init(){
        super.init(id1: -1, topic: "Wikipedia", q: "How many articles are there on the English Wikipedia?",opts: ["A. Less than one million","B. Between 3 and 5 Million", "C. Between 6 and 10 million", "D. More than 10 million"], resps: [30, 42, 200, 107], corr: 2, cat: "Example Question", diff: 0, mQuote: wikipediaQuote)
    }
    override func complete(index: Int) {
        complete = true
        selectedIndex = index
    }
    override func report(comment: String) {
        reported = ""
    }
    override func see(){
        
    }
}

struct InstructionsFile: View {
    var finish : ()->Void
    var exampleQuestion : demoQuestion
    let textToDisplay = ["Here is an example of a question. \nTry picking the answer.", "The numbers on the right of each option show what percentage of people that that option.", "Try liking or disliking this question by tapping the thumbs in the blue oval.", "Click the Article icon in the bottom left of the question to see a quote which explains the answer.", "Try tapping anywhere on the card that pops up from the Article button. This will load the full article.", "Tap the button in the bottom right. This will give you the option to report bad questions.", "This is what your home page will look like.", "Click the dropdown menu labeled random at the top of the screen. This allows you to select the category of new questions.", "That's the whole tutorial. Go play some trivia."]
    @State var currentStep : Int
    init(finishAction : @escaping ()->Void){
        exampleQuestion = demoQuestion()
        currentStep = 0
        finish = finishAction
    }
    func setQuestion(){
        switch (currentStep){
        case 0:
            return
        case 1:
            if !exampleQuestion.complete {
                exampleQuestion.complete(index: 2)
            }
            return
        default:
            return
        }
    }
    var body: some View {
        VStack{
            if currentStep < 6 {
                NavigationView {
                    VStack {
                        Text(textToDisplay[currentStep])
                            .font(.title)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background{
                                Rectangle()
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                    .shadow(color: .blue, radius: 5)
                            }
                        ScrollView {
                            QuestionMenuView(q:exampleQuestion)
                        }
                        VStack {
                            HStack {
                                Spacer()
                                if currentStep > 0 {
                                    Spacer()
                                    Button(action: {currentStep -= 1}){
                                        Text("Previous Page")
                                            .font(.headline)
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
                                }
                                if currentStep < 7 {
                                    Spacer()
                                    Button(action: {currentStep += 1; setQuestion()}){
                                        Text("Next Page")
                                            .font(.headline)
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
                                }
                                Spacer()
                                
                                
                            }
                        }
                    }
                    .padding(15)
                }
            } else {
                VStack {
                    topBarView(changeable: false)
                    ScrollView {
                        VStack {
                            QuestionMenuView(q:exampleQuestion)
                            QuestionMenuView(q:exampleQuestion)
                        }
                    }
                    Text(textToDisplay[currentStep])
                        .font(.title)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background{
                            Rectangle()
                                .cornerRadius(10)
                                .foregroundColor(.white)
                                .shadow(color: .blue, radius: 5)
                        }
                        .padding()
                    HStack {
                        Spacer()
                        if currentStep > 0 {
                            Spacer()
                            Button(action: {currentStep -= 1}){
                                Text("Previous Page")
                                    .font(.headline)
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
                        }
                        if currentStep < 8 {
                            Spacer()
                            Button(action: {currentStep += 1}){
                                Text("Next Page")
                                    .font(.headline)
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
                        }
                        if currentStep == 8 {
                            Spacer()
                            Button(action: {finish()}){
                                Text("Start Playing!")
                                    .font(.headline)
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
                        }
                        Spacer()
                        
                        
                    }
                    .padding()
                }
            }
            HStack {
                Spacer()
                Button("exit tutorial"){
                    finish()
                }
                Spacer().frame(width:25)
            }
        }
    }
}

#Preview {
    InstructionsFile(finishAction: {})
}
