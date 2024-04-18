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
            
            //turn off toggle to prevent multiple attempts
            
            if question.complete == false {
                question.complete = true
                question.selectedIndex = x
                qRec.pub.seeProblem(q: question)
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
                    Text(question.complete&&question.correctIndex==x ? (x==question.selectedIndex ? "✓" : "x") : " ")
                        .foregroundColor(.black)
                        .opacity(question.complete ? 1:0)
                        .fontWeight(.heavy)
                    Spacer()
                    Text("\(Int(getFillPercent()*1000)/10)%")
                        .padding()
                        .fontWeight(.regular)
                        .opacity(question.complete ? 0.7:0)
                        .foregroundColor(.black)
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
//    var timer : Timer
    init(question:Question){
//        timer = Timer()
        mquestion = question
        optionsView = []
        for i in 0..<question.options.count{
            optionsView.append(QuestionAnswer(question: question, x: i))
        }
    }
}
