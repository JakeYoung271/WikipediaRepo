//
//  HistoryManager.swift
//  TriviaWiki
//
//  Created by Jake Young on 5/30/24.
//

import Foundation

class HistoryManager {
    static let shared = HistoryManager()
    var seen: [String: [String: Any]]
    var orderedHist: [Int]
    var ratings : [Int]
    var numSeen : [Int]
    var ratingApplied: Set<Int>
    var toUpload : [String:[String: Any]]
    private init(){
        ratingApplied = Set<Int>()
        ratings = [1200,1200,1200]
        numSeen = [0,0,0]
        orderedHist = [Int]()
        seen = [String:[String:Any]]()
        toUpload = [String:[String: Any]]()
        initializeHistoryManager()
        
        print("Finished running History Manager initializer: ")
        print("My ratings are: \(ratings)")
        print("numSeen contains: \(numSeen)")
        print("orderedHist contains: \(orderedHist)")
        print("seen has length: \(seen.count), here are its entries: \(seen)")
        print("toUpload has length: \(toUpload.count), here are its entries: \(toUpload)")
    }
    func see(q:Question){
        print("SEEING Question with id \(q.id) ")
        if !seen(id: q.id){
            orderedHist.append(q.id)
            print("appended question to orderedHist")
            print("Here are the last 3 entries of orderedHist: ")
            //debugging:
            for i in 1...3{
                if i <= orderedHist.count{
                    print("Ordered hist of -\(i) is \(orderedHist[orderedHist.count - i])")
                }
            }
        }
        seen[String(q.id)] = q.makeDict()
        toUpload[String(q.id)] = q.makeDict()
        
        if !ratingApplied.contains(q.id){
            if q.complete || q.sawHint {
                print("updating Ratings: here are ratings before: \(HistoryManager.shared.ratings)")
                ratingApplied.insert(q.id)
                updateRating(q: q)
                print("updated Ratings: here are ratings after: \(HistoryManager.shared.ratings)")
            }
        }
        Task{await fbase.pub.updateActivityLog(forced: false)}
        
    }
    func getRatingChange(playerRating : Int, questionRating : Int, performance: Int, K:Int) ->Int
    {
        print("calculating rating change with these params : pRating : \(playerRating), qRating : \(questionRating), performance : \(performance), K : \(K)")
        let denom = 1.0 + pow(10, Double(questionRating - playerRating) / 400.0)
        let expectedVal = 1.0 / denom
        let diff = Double(performance) - expectedVal
        let scaledDiff = Double(K) * diff
        print("result is \(round(scaledDiff))")
        return Int(round(scaledDiff))
    }
    
    func updateRating(q:Question){
        let index = qRec.pub.generalCat(cat: q.subject)
        let delta = getRatingChange(playerRating: ratings[index],
                                    questionRating: DataManager.shared.ratings[q.id],
                                    performance: q.selectedIndex == q.correctIndex ? 1 : 0,
                                    K: numSeen[index] > 25 ? 16 : Int(800.0 / Double(1 + 2*numSeen[index])))
        ratings[index] += delta
        numSeen[index] += 1
        
    }
    
    func seen(id:Int) -> Bool{
        return seen[String(id)] != nil
    }
    func initializeHistoryManager(){
        print("RUNNING HistoryManager::initializeHistoryManager, looking for document")
        if findJSON(name: "HistoryManager"){
            print("HistoryManager::initializeHistoryManager found HistoryManager.json")
            let data = readJSON(name: "HistoryManager")!
            seen = data["history"] as! [String: [String: Any]]
            toUpload = data["toUpload"] as! [String: [String: Any]]
            ratings = data["ratings"] as! [Int]
            orderedHist = data["ordered"] as! [Int]
            return
        }
        print("HistoryManager::initializeHistoryManager did not find found HistoryManager.json")
    }
    func save(){
        print("RUNNING HistoryManager::save")
        let data = ["history" : seen, "ratings": ratings, "ordered": orderedHist, "toUpload": toUpload] as [String : Any]
        writeJSON(name: "HistoryManager", data: data)
    }
}
