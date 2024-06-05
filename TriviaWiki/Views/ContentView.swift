//
//  ContentView.swift
//  TriviaWiki
//
//  Created by Jake Young on 3/8/24.
//

import SwiftUI
import Combine


struct loadingView: View {
    var body: some View {
        Text("Questions are loading")
            .font(.title)
        Text("If this message is not going away, check your internet connection or go to your profile tab to report an issue")
    }
}

class displayIDs: ObservableObject {
    @Published var IDList : [Int]
    static var pub = displayIDs()
    private init(){
        IDList = [Int]()
    }
    func clearList(){
        IDList = []
    }
}

struct ContentView: View {
    @State var counter: Int
    @ObservedObject var disp : displayIDs
    init(){
        counter = 1
        disp = displayIDs.pub
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                topBarView(changeable: true)
                    ScrollView {
                        LazyVStack {
                            ForEach(disp.IDList, id: \.self){x in
                                QuestionMenuView(q: questionFactory.shared.getQuestion(id: x))
                                Divider()
                                    .frame(height:1)
                                    .overlay(.gray)
                            }
                            loadingView()
                                .padding()
                                .onAppear
                                {
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                }
                                .onDisappear
                                {
                                }
                        }
                }
            }
        }
    }
}

struct topBarView: View {
    let changeable : Bool
    var body: some View{
            VStack (spacing:0){
                Rectangle()
                    .fill(.white)
                    .frame(height:50)
                    .overlay(
                        HStack {
                            Spacer()
                            Text("Browse")
                                .font(.title2)
                            Spacer()
                            TopicMenu(changeable: changeable)
                            Spacer()
                            NavigationLink(destination: HistList()) { Text("History")
                            }
                            Spacer()

                        }
                            .offset(y:-10),
                        alignment: .bottom
                )
            Divider()
        }
    }
}

struct TopicMenu: View {
    let changeable : Bool
    @State private var selection = "Random"
    let topics = ["Arts and Culture", "Science", "Humanities", "Random"]
    var body: some View{
        VStack{
            Picker("Select a Topic", selection: $selection){
                ForEach(topics, id:\.self){ x in
                    Text(x)
                    }
                }
            .pickerStyle(.menu)
            .onReceive(Just(selection)) { newValue in
                // Action to perform when selection changes
                print("Selected topic: \(newValue)")
                if changeable && qRec.pub.updateMode(newMode: selection){
                    displayIDs.pub.clearList()
                }
            }
        }
    }
}

//class QuestionHistoryManager: ObservableObject{
//    static var pub = QuestionHistoryManager()
//    @Published var questionsList : [Question]
//    var IDCache : [Int : Question]
//    private init(){
//        questionsList = [Question]()
//        IDCache = [Int : Question]()
//    }
//    func addQuestion(q : Question){
//        questionsList.insert(q, at:0)
//        IDCache[q.id] = q
//    }
//}

struct HistList: View {
    var body: some View{
        VStack {
            List{
                ForEach(HistoryManager.shared.orderedHist.reversed(), id: \.self){x in
                    NavigationLink (destination: ScrollView{QuestionMenuView(q: questionFactory.shared.getQuestion(id: x))})
                    {
                        Text(DataManager.shared.getQuestionN(n: x)["question"] as! String)
                    }
                }
                Text("End of History")
                if HistoryManager.shared.orderedHist.count==0 {
                    Text("Go answer some questions and they will appear in your history here")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
