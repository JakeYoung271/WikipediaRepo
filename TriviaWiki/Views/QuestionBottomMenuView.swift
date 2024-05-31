//
//  QuestionDividerView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/18/24.
//

import SwiftUI


struct QuestionMenuView: View, Identifiable {
    @ObservedObject var question: Question
    @ObservedObject var items : optionsWrapper
    @State var notRated = true
    @State var report = false
    @State var notReported = true
    @State var enjoyed : Bool?
    @State var forSure = false
    @State var showCard = false
    @State var hintSeen = false
    let id: UUID
    init(q:Question){
        id = UUID()
        question = q
        items = optionsWrapper(question: q, inert : false)
    }
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .cornerRadius(20)
                
                //return here to adjust handling of different text sizes and lengths
                
                VStack {
                    Text(question.question).font(.custom("texgyretermes-regular", size:25))
                        .multilineTextAlignment(.leading)
                    Spacer()
                        .frame(height:20)
                    ForEach(items.optionsView){x in
                        x
                    }
                    Spacer()
                        .frame(height:10)
                    QuestionMenu(question: question, showHint: $showCard, report: {report.toggle()}, showAreYouSure: {forSure.toggle()})
                }
                .padding(10)
                if report {
                    ReportMenu(questionID: question.id, notReported: notReported, exitAction: {report = false}, submitAction: {notReported = false})
                        .fixedSize()
                }
                if forSure {
                    AreYouSureView(yes:{forSure.toggle(); showCard = true; question.sawHint = true}, no: {forSure.toggle()})
                        .padding()
                }
            }
        }
}

struct QuestionMenu: View {
    @ObservedObject var question: Question
    @Binding var showHint : Bool
    let report: () -> Void
    let showAreYouSure: () -> Void
    var body: some View {
        VStack {
            if showHint {
                    NavigationLink(destination:  WebView(url:question.link)
                        .onAppear(perform:{showHint.toggle()})){
                            WikiArticleThumbnailView(question: question)
                    }
            }
            HStack{
                Spacer()
                    .frame(width:5)
                Article(action: {decideToShow()})
                Spacer()
                LikeDislikeMenu(question: question)
                Spacer()
                ReportButton(reportAction: report)
                Spacer()
                    .frame(width:5)
            }
        }
    }
    func decideToShow(){
        if question.complete || question.sawHint {
            showHint.toggle()
        } else {
            if showHint {
                showHint = false
            } else {
                showAreYouSure()
            }
        }
    }
}

struct ReportButton: View {
    var reportAction : () -> Void
    var body: some View{
        VStack {
            Button (action: reportAction) {
                Image(systemName: "exclamationmark.bubble")
                    .font(.title2)
                    .padding(18)
                    .background(
                        Circle()
                            .fill(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.blue)
                                    .opacity(0.5)))}
    }
    }
}

struct Article: View {
    var action : () -> Void
    var body: some View{
        VStack {
            Button (action: action) {
                Image(systemName: "newspaper")
                    .font(.title2)
                    .padding(18)
                    .background(
                        Circle()
                            .fill(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.blue)
                                    .opacity(0.5)))}
    }
    }
}

struct Info: View {
    var body: some View{
        VStack {
            Button (action: {}) {
                Image(systemName: "info")
                    .font(.title2)
                    .padding(18)
                    .background(
                        Circle()
                            .fill(.white)
                            .padding(8)
                            .background(
                                Circle()
                                    .fill(.blue)
                                    .opacity(0.5)))}
    }
    }
}

struct LikeDislikeMenu: View {
    @State var colorUP = Color.white
    @State var colorDOWN = Color.white
    @ObservedObject var question: Question
    var body: some View {
        HStack{
            Button(action: {question.like(); setColor() }) {
                Image(systemName: "hand.thumbsup")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(colorUP))
                    .padding(10)
            }
            Button(action: { question.dislike(); setColor()}) {
                Image(systemName: "hand.thumbsdown")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                    Circle()
                        .fill(colorDOWN))
                .padding(10)
            }
        }
        .background(
        Rectangle()
            .fill(.blue)
            .cornerRadius(30)
            .opacity(0.5)
            
        )
    }
    func setColor(){
        if let enjoyed = question.liked {
            if enjoyed {
                colorUP = Color("LightGreen")
                colorDOWN = Color(.white)
            } else {
                colorUP = Color(.white)
                colorDOWN = Color("LightRed")
            }
        } else {
            colorUP = Color(.white)
            colorDOWN = Color(.white)
        }
    }
}

#Preview {
    QuestionMenuView(q:Question())
}
