//
//  QuestionModel.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import Foundation
import SwiftUI

var example = Question()

class Question: ObservableObject, Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    func hash(into hasher: inout Hasher){
        hasher.combine(ObjectIdentifier(self))
    }
    
    let id: Int
    let link: String
    let question: String
    let options: [String]
    let responseNums: [Int]
    let correctIndex: Int
    let subject: String
    let difficulty: Int
    @Published var selectedIndex: Int
    @Published var complete: Bool
    @Published var clicks: Double
    
    init(){
    id = 0
    link =  "https://en.wikipedia.org/wiki/default"
    question = "This is the default question, if you are seeing this, there is a bug. Please report it in your profile"
    options = ["Cockroach","Fly", "Termite", "Beatle"]
    correctIndex = 1
    subject = "TestQuestion"
    difficulty = 1
    selectedIndex = 5
    complete = false
    //timeOnScreen = 0.1
    clicks = 0.0
    responseNums = [0,0,0,0]
    }
    
    init(id1 : Int){
    let sResult = CoreDataStack.shared.fetchID(id:id1)
    if sResult.count != 1 {
        for i in sResult{
            print(i.question)
        }
        print(sResult.count)
        print("tried to initialize question with fetched ID, failed on question with id \(id1)")
        id = id1
        link =  "https://en.wikipedia.org/wiki/default"
        question = "Failed to Generate Question with id \(id). Guess why the answer options are relevant. Hint (this question is a ..."
        options = ["Cockroach","Fly", "Termite", "Beatle"]
//        responseRates = [0.5,0.5,0.5,0.5]
        correctIndex = 1
        subject = "TestQuestion"
        difficulty = 1
        selectedIndex = 5
        complete = false
        //timeOnScreen = 0.1
        clicks = 0.0
        responseNums = [0,0,0,0]

    }
    else{
        let Qbody = sResult[0]
        id = id1
        link =  "https://en.wikipedia.org/wiki/" + (Qbody.topic!).replacingOccurrences(of: " ", with: "_")
        question = Qbody.question!
        options = Qbody.answers!
        correctIndex = Int(Qbody.correct)
        subject = Qbody.category!
        difficulty = 0
        selectedIndex = 5
        complete = false
        clicks = 0.0
        responseNums = allResponses[id1]
        }
    }
    
    
    init(id1: Int, topic: String, q: String, opts: [String], resps: [Int], corr: Int, cat: String, diff: Int){
    id = id1
    link =  "https://en.wikipedia.org/wiki/" + topic.replacingOccurrences(of: " ", with: "_")
    question = q
    options = opts
    correctIndex = corr
    subject = cat
    difficulty = diff
    selectedIndex = 5
    complete = false
    clicks = 0.0
    responseNums = resps
    }
    
}
