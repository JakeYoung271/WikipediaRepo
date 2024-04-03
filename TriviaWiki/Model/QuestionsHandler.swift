//
//  QuestionsHandler.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/2/24.
//

import Foundation

class QuestionDatabase: ObservableObject {
    var toDisplay: DisplayList
    init(){
        toDisplay = DisplayList()
    }
    func fillList()async{
        var qs = await getAllQuestions()
        for q in qs {
            toDisplay.add(q:q)
        }
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
