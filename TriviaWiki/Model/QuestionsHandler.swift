//
//  QuestionsHandler.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/2/24.
//

import Foundation

class QuestionDatabase: ObservableObject {
    //@Published var toDisplay: DisplayList
    var qs: [Question]
    var index: Int
    @Published var qViews: [QuestionDividerView]
    @Published var loaded: Bool
    init(){
        index = 0
        qs = [Question]()
        qViews = [QuestionDividerView]()
        //toDisplay = DisplayList()
        loaded = false
    }
    func fillList()async{
        let querie1 = await getAllQuestions()
        for q in querie1 {
            print("q's gotten")
            qs.append(q)
        }
        loaded = true
        print(qs.count)
    }
    func addDefault()async{
        //toDisplay.add(q:Question())
    }
    func testAdd(){
        qs.append(Question())
    }
    func loadSome(){
        if index==qs.count{
            print("index error")
            print(qs.count)
            return
        }
        qViews.append(QuestionDividerView(q:qs[index]))
        index += 1
    }
}

class categoryBucket {
    let category: String
    var questions: [Question]
    init(cat: String){
     category = cat
     questions = [Question]()
    }
}
