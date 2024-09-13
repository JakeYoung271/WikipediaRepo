//
//  ReportMenu.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/28/24.
//

import SwiftUI
import Combine

struct ReportMenu: View {
    let question: Question
    let notReported : Bool
    @State var selection = "null"
    let exitAction : () -> Void
    let submitAction : () -> Void
    @State var submitted = false
    @State var response = "Select Reason for Report"
    @State var comment = ""
    let actions = ["Select Reason for Report", "Dumb/Uninteresting/Boring", "Factually Incorrect", "Misleading/Unclear", "Offfensive/Insensitive", "Bad Hint/Article Quote", "Other"]
    var body: some View {
        VStack{
            HStack {
                Spacer()
                
            }
            if submitted {
                VStack{
                    Text("Your report helps \n improve the app. \n \n Thank you!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Button(action:{
                        exitAction()}){
                            Text("exit")
                        }
                }
                .padding(20)
                .background(
                    Rectangle()
                        .fill(.white))
                .cornerRadius(20)
                .padding(1)
                .background(Rectangle().fill(.black).cornerRadius(20))
                .shadow(radius: 10)
                .overlay(
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: exitAction) {
                                Image(systemName: "x.circle")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .offset(x:8, y:-8)
                                    .padding(-2)
                                    .background(
                                        Circle()
                                            .fill(.white)
                                            .offset(x:8, y:-8)
                                            .shadow(radius:10))
                            }
                        }
                        Spacer()
                    }
                )
            }
            else{
                if notReported {
                    VStack{
                        Text("Report Question\n")
                            .font(.title)
                        Text("this question is:")
                            .font(.title3)
                        Picker("Select reason", selection: $response) {
                            ForEach(actions, id:\.self){
                                x in
                                Text(x)
                            }
                        }
                        Button(action:{
                            print(response)
                            
                            if response != actions[0]
                            {
                                question.reportQuestion(reason: response)
                                submitted = true
                                submitAction()
                            }
                        }){
                            Text("Submit report")
                        }
                    }
                    .padding(20)
                    .background(
                        Rectangle()
                            .fill(.white))
                    .cornerRadius(20)
                    .padding(1)
                    .background(Rectangle().fill(.black).cornerRadius(20))
                    .shadow(radius:10)
                    .overlay(
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: exitAction) {
                                    Image(systemName: "x.circle")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .offset(x:8, y:-8)
                                        .padding(-2)
                                        .background(
                                            Circle()
                                                .fill(.white)
                                                .offset(x:8, y:-8)
                                                .shadow(radius:10))
                                }
                            }
                            Spacer()
                        }
                    )
                }
                else {
                    VStack{
                        Text("Report Question \n")
                            .font(.title)
                        Text("Report recieved, thank you!\n")
                        Button(action:{exitAction()}){
                            Text("exit")
                        }
                    }
                    .padding(20)
                    .background(
                        Rectangle()
                            .fill(.white))
                    .cornerRadius(20)
                    .padding(1)
                    .background(Rectangle().fill(.black).cornerRadius(20))
                    .shadow(radius:10)
                    .overlay(
                        VStack {
                            HStack {
                                Spacer()
                                Button(action: exitAction) {
                                    Image(systemName: "x.circle")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .offset(x:8, y:-8)
                                        .padding(-2)
                                        .background(
                                            Circle()
                                                .fill(.white)
                                                .offset(x:8, y:-8)
                                                .shadow(radius:10))
                                }
                            }
                            Spacer()
                        }
                    )
                }
            }
        }
    }
}
