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
            question.complete.toggle()
            question.selectedIndex = x
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
                        .padding()
                    Text(question.complete&&question.correctIndex==x ? (x==question.selectedIndex ? "✓" : "x") : " ")
                        .foregroundColor(.black)
                        .opacity(question.complete ? 1:0)
                        .fontWeight(.heavy)
                    Spacer()
                    Text("\(Int(Float(question.responseRates[x])*1000)/10)%")
                        .padding()
                        .fontWeight(.regular)
                        .opacity(question.complete ? 0.7:0)
                        .foregroundColor(.black)
                }
                .overlay() {
                    GeometryReader {geo in
                        RoundedRectangle(cornerRadius:20)
                            .fill(edgeColor)
                            .frame(width:geo.size.width*question.responseRates[x], height:geo.size.height)
                            .opacity(question.complete ? 0.2 : 0.0)
                    }
                }
            }
            .fixedSize(horizontal: false, vertical:true)
        }
    }
}
