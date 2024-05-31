//
//  AnswerOptionView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI

struct QuestionAnswer: View, Identifiable {
    @ObservedObject var question: Question
    var x: Int
    let id = UUID()
    let inert : Bool
    var body: some View {
        var edgeColor = Color(.gray)
        if !question.complete {
        }
        else if question.selectedIndex==question.correctIndex && question.selectedIndex==x{
            let _ = edgeColor = Color(.green)
        }
        else if question.selectedIndex==x{
            let _ = edgeColor = Color(.red)
        }
        else {
            
        }
        Button(action:{
            if inert {
                question.complete.toggle()
                question.selectedIndex = x
            }
            else {
                if question.complete == false {
                    question.complete(index: x)
                    QuestionHistoryManager.pub.addQuestion(q: question)
                }
            }
        }){
            ZStack {
                RoundedRectangle(cornerRadius:20)
                    .strokeBorder(edgeColor, lineWidth:  1)
                    .shadow(radius: 10)
                HStack {
                    Text(question.options[x])
                        .fontWeight( .regular)
                        .foregroundColor(Color.black)
                        .font(.custom("texgyretermes-regular",size:18))
                        .multilineTextAlignment(.leading)
                        .padding()
                    if question.complete&&question.correctIndex==x{
                        Text("✓")
                            .foregroundColor(.black)
                            .fontWeight(.heavy)}
                    Spacer()
                    if question.complete{
                        Text("\(Int(getFillPercent()*1000)/10)%")
                            .padding()
                            .fontWeight(.regular)
                            .opacity(0.7)
                            .foregroundColor(.black)
                    }
                }
                .overlay() {
                    GeometryReader {geo in
                        RoundedRectangle(cornerRadius:20)
                            .fill(edgeColor)
                            .frame(width:geo.size.width*CGFloat(getFillPercent()), height:geo.size.height)
                            .opacity(question.complete ? 0.2 : 0.0)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical:true)
        }
    }
    func getFillPercent() -> Double{
        var result : Double
        var total = 0.0
        for x in question.responseNums{
            total += Double(x)
        }
        if total==0{
            result = 0.25
        }
        else{
            result = (Double(question.responseNums[self.x])) / total
        }
        return result
    }
}

class optionsWrapper: ObservableObject {
    @ObservedObject var mquestion : Question
    var optionsView: [QuestionAnswer]
    var inert : Bool
//    var timer : Timer
    init(question:Question, inert: Bool){
//        timer = Timer()
        mquestion = question
        optionsView = []
        self.inert = inert
        for i in 0..<question.options.count{
            optionsView.append(QuestionAnswer(question: question, x: i, inert: self.inert))
        }
    }
}
