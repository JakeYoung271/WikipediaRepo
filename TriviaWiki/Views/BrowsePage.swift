//
//  BrowsePage.swift
//  TriviaWiki
//
//  Created by Jake Young on 9/12/24.
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

struct BrowsePage: View {
    let qFactory = QuestionFactory.shared
    @State var counter: Int
    @Binding var showHome : Bool
    @ObservedObject var disp : displayIDs
    init(homeVar : Binding<Bool>){
        counter = 1
        disp = displayIDs.pub
        self._showHome = homeVar
    }
    
    var body: some View {
        NavigationView {
            VStack (spacing:0){
                topBarView(showHome: $showHome)
                    ScrollView {
                        LazyVStack {
                            ForEach(disp.IDList, id: \.self){x in
                                QuestionMenuView(q: qFactory.getQuestion(id: x))
                                Divider()
                                    .frame(height:1)
                                    .overlay(.gray)
                            }
                            loadingView()
                                .padding()
                                .onAppear
                                {
                                    print("in content view: adding question \(self.counter)")
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                    disp.IDList.append(qRec.pub.recommend())
                                }
                                .onDisappear
                                {
                                    print("loader disappeared")
                                }
                        }
                }
            }
        }
    }
}

struct topBarView: View {
    @Binding var showHome : Bool
    var body: some View{
            VStack (spacing:0){
                Rectangle()
                    .fill(.white)
                    .frame(height:50)
                    .overlay(
                        HStack {
                            Spacer()
                            Button(action: {showHome.toggle()}) {
                                Text("Home")
                                    .font(.title2)
                            }
                            Spacer()
                            TopicMenu()
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
    @State private var selection = "Random"
    let topics = ["Arts and Culture", "Science", "Social Studies", "Random"]
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
                if qRec.pub.updateMode(newMode: selection){
                    displayIDs.pub.clearList()
                }
            }
        }
    }
}

struct HistList: View {
    var body: some View{
        VStack {
            List{
                ForEach(DataManager.shared.seenIDs.reversed(), id:\.self){x in
                    NavigationLink (destination: QuestionMenuView(q:QuestionFactory.shared.getQuestion(id: x)))
                    {
                        Text(QuestionFactory.shared.getQuestion(id:x).question)
                    }
                }
            }
            Text("End of Question History")
        }
    }
}

#Preview {
    ContentView()
}
