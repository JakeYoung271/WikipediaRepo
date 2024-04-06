//
//  QuestionModel.swift
//  WikipediaApp
//
//  Created by Jacob Young on 3/7/24.
//

import Foundation
import SwiftUI

var example = Question()

class Question: ObservableObject{
    let id: Int
    let link: String
    let question: String
    let options: [String]
    let responseRates: [CGFloat]
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
    responseRates = [0.50,0.25,0.125,0.125]
    correctIndex = 1
    subject = "TestQuestion"
    difficulty = 1
    selectedIndex = 5
    complete = false
    //timeOnScreen = 0.1
    clicks = 0.0
    responseNums = [0,0,0,0]
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
        var total = 0.0
    for x in resps{
        total += Double(x)
        }
    if total==0{
        responseRates = [0.25,0.25,0.25,0.25]
        }
    else{
        responseRates = resps.map {x in  CGFloat((Double(x)) / total)}
        }
    }
    
}

class qDatabase {
    private var questions: Dictionary<Int, Question>
    private var seen: Dictionary<Int, Int>
    init(){
        questions = Dictionary<Int, Question>()
        seen = Dictionary<Int, Int>()
    }

    func getQ(id:Int) ->Question {
        if let resultq = questions[id]{
            return resultq
        }
        print("failed to get question with id \(id)")
        return Question()
    }
    func getSeen(id:Int) ->Int {
        if let chosen = seen[id]{
            return chosen
        }
        return -1
    }
    func addToSeen(q:Question){
        if let chosen = seen[q.id]{
            print("Question with title \(q.question) already in seen")
            return
        }
        seen[q.id] = q.selectedIndex
    }
    func addToQuestions(q:Question){
        if let found = questions[q.id]{
            print("attempted to add question: \(q.question) which was already in dictionary of Questions")
            return
        }
        questions[q.id] = q
    }
    
}

class qHandler: ObservableObject {
    @Published var displayIDs : [Int]
    var buckets: [categoryBucket]
    //var data: qDatabase
    init(){
        displayIDs = [Int]()
        buckets = [categoryBucket]()
        //data = data1
    }
    func addQ(id:Int){
        displayIDs.append(id)
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
