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
                    Spacer(minLength: 20)
                    //Divider()
                    //Divider()
                    Spacer(minLength: 20)
                    ForEach(items.optionsView){x in
                        x
                    }
                    QuestionMenu(question: question, report: {report.toggle()}, like: like, dislike: dislike)
                }
                .padding()
                if report {
                    ReportMenu(questionID: question.id, notReported: notReported, exitAction: {report = false}, submitAction: {notReported = false})
                        .fixedSize()
                }
            }
        }
   func like(){
        notRated = false
        enjoyed = true
       print("liked")
       fbase.pub.addResponse(id: question.id, likedQ: true)
    }
    func dislike(){
        notRated = false
        enjoyed = false
        print("disliked")
        fbase.pub.addResponse(id: question.id, likedQ: false)
    }
}

struct QuestionMenu: View {
    @ObservedObject var question: Question
    @State var showHint = false
    let report: () -> Void
    let like: () -> Void
    let dislike: () -> Void
    var body: some View {
        VStack {
            if showHint {
                    NavigationLink(destination: WikipediaThumbnail(question: question)){
                        WikiArticleThumbnailView(question:question)
                    }
            }
            HStack{
                Spacer()
                    .frame(width:5)
                Article(action: {showHint.toggle()})
                Spacer()
                LikeDislikeMenu(likeAction: like, dislikeAction: dislike)
                Spacer()
                ReportButton(reportAction: report)
                Spacer()
                    .frame(width:5)
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
    let likeAction : () -> Void
    let dislikeAction : () -> Void
    @State var colorUP = Color.white
    @State var colorDOWN = Color.white
    var body: some View {
        HStack{
            Button(action: {likeAction(); setColor(like: true)}) {
                Image(systemName: "hand.thumbsup")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(10)
                    .background(
                        Circle()
                            .fill(colorUP))
                    .padding(10)
            }
            Button(action: {dislikeAction(); setColor(like: false)}) {
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
    func setColor(like:Bool){
        if colorUP == Color.white && colorDOWN == Color.white {
            if like {
                colorUP = Color("LightGreen")
            } else {
                colorDOWN = Color("LightRed")
            }
        } else {
            if like {
                if colorUP == Color("LightGreen") {
                    colorUP = Color.white
                } else {
                    colorUP = Color("LightGreen")
                    colorDOWN = Color.white
                }
            } else {
                if colorDOWN == Color("LightRed") {
                    colorDOWN = Color.white
                } else {
                    colorUP = Color.white
                    colorDOWN = Color("LightRed")
                }
            }
        }
    }
}

#Preview {
    QuestionMenuView(q:Question(id1:1))
}
