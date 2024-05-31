//
//  DataManager.swift
//  TriviaWiki
//
//  Created by Jake Young on 5/30/24.
//

import Foundation

extension String: Error {}

class DataManager {
    static let shared = DataManager()
    let TIME_OFFSET = 1713426675.0
    var questionsList : [[String: Any]]
    var dumps : [Int]
    var ratingsDoc : [String: Any]
    var numQuestions: Int
    var ratings : [Int]
    var timesSeen : [[Int]]
    var dumpsLoaded: Int
    private init(){
        questionsList = [[String: Any]]()
        numQuestions = 0
        dumpsLoaded = 0
        ratingsDoc = readJSON(name: "currRatings")!
        dumps = ratingsDoc["dumps"] as! [Int]
        ratings = ratingsDoc["allRatings"] as! [Int]
        timesSeen = [[Int]]()
        initializeQuestionList()
        setTimesSeen()
    }
    
    func setTimesSeen() {
        let responsesDict = ratingsDoc["allResponses"] as! [[String:[Int]]]
        timesSeen = [[Int]]()
        for i in 0..<numQuestions {
            let toAdd = responsesDict[i]
            timesSeen.append(toAdd[String(i)] as! [Int])
        }
    }
    
    //sets up questionList and asserts that num of questions read matches number in list and such. Calls addDump to add one more dump if necessary assuming you will rarely need more than one at once
    func initializeQuestionList(){
        for i in 0..<dumps.count {
            let length = dumps[i]
            let name = "dump" + String(i)
            if findJSON(name:name){
                if let data = readJSON(name:name){
                    questionsList.append(contentsOf: data["qArray"] as! [[String: Any]])
                } else {
                    print("FATAL ERROR: failed to read found JSON in DataManager.initializeQuestionList")
                    break
                }
            } else {
                print("POTENTIAL ERROR: failed to find JSON \(name) when running DataManager::initializedQuestionList")
                break
            }
            numQuestions += length
            dumpsLoaded += 1
        }
        if numQuestions != questionsList.count {
            print("FATAL ERROR: DataManager.questionList count mismatched numQuestions")
        }
    }
    
    func getQuestionN(n:Int) -> [String: Any]{
        if n < numQuestions {
        } else {
                print("FATAL ERROR: ASKED FOR QUESTION NOT IN RANGE")
            }
            return questionsList[n]
        }
    
    //function for adding one more dump to the files
    func addDump(name:String){
        print("Running Add Dump")
        if findJSON(name:name){
            if let data = readJSON(name:name){
                let toAdd = data["qArray"] as! [[String: Any]]
                questionsList.append(contentsOf: toAdd)
                numQuestions += toAdd.count
                dumpsLoaded += 1
            } else {
                print("FATAL ERROR: failed to read found JSON in DataManager.addDump")
            }
        } else {
            print("FATAL ERROR: failed to find \(name) after calling addDump on it!")
        }
    }
    
    func updateRatings() async {
        print("Running DataManager::UpdateRatings")
        let time = Int(NSDate().timeIntervalSince1970 - TIME_OFFSET)
        let lastUpdate = ratingsDoc["time"] as! Int
        if time - lastUpdate > 43200 {
            await fbase.pub.getRatingsDoc()
            ratingsDoc = readJSON(name: "currRatings")!
            dumps = ratingsDoc["dumps"] as! [Int]
            var counter = dumpsLoaded
            while counter < dumps.count {
                if await fbase.pub.getDumpDoc(name: "dump\(counter)"){
                    addDump(name:"dump\(counter)")
                    counter += 1
                } else {
                    print("ERROR: failed to get dump\(counter), will re-attempt on next refresh")
                    break
                }
            }
        }
    }
}
