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
    var ratings : [String: Any]
    var numQuestions: Int
    var dumpsLoaded: Int
    init(){
        questionsList = [[String: Any]]()
        numQuestions = 0
        dumpsLoaded = 0
        ratings = readJSON(name: "currRatings")!
        dumps = ratings["dumps"] as! [Int]
        initializeQuestionList()
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
                Task { if await fbase.pub.getDumpDoc(name:name){
                        addDump(name:name)
                    } else {
                        print("ERROR: Failed to retrieve dump \(name) in call to fbase::getDumpDoc from DataManager::initializeQuestionsList")
                    }}
                break
            }
            numQuestions += length
            dumpsLoaded += 1
        }
        if numQuestions != questionsList.count {
            print("FATAL ERROR: DataManager.questionList count mismatched numQuestions")
        }
    }
    
    //function for adding one more dump to the files
    func addDump(name:String){
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
        var time = Int(NSDate().timeIntervalSince1970 - TIME_OFFSET)
        var lastUpdate = ratings["time"] as! Int
        if time - lastUpdate > 43200 {
            await fbase.pub.getRatingsDoc()
            ratings = readJSON(name: "currRatings")!
            dumps = ratings["dumps"] as! [Int]
            var counter = dumpsLoaded
            while counter < dumps.count {
                if await fbase.pub.getDumpDoc(name: "dump\(counter)"){
                    addDump(name:"dump\(counter)")
                } else {
                    print("ERROR: failed to get dump\(counter), will re-attempt on next refresh")
                }
            }
        }
    }
}
