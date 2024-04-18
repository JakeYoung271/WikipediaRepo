//
//  QueryHandler.swift
//  TriviaWiki
//
//  Created by Jake Young on 4/2/24.
//

import Foundation
import Firebase
import FirebaseCore
import UIKit


class fbase {
    static let pub = fbase()
    private init(){
    }
//    func getQsInArr(ids : [Int]) async -> [Question]{
//            var result = [Question]()
//        if ids.count == 0{
//            return result
//        }
//            print("got here?")
//            let db = Firestore.firestore()
//            let qs = db.collection("questions")
//            print("got here1")
//            do {
//                print("got to do statement")
//                let querySnapshot = try await qs.whereField("id", in: ids).getDocuments()
//              for d in querySnapshot.documents {
//                print("\(d.documentID) => \(d.data())")
//                let ques = Question(id1: d["id"] as! Int,
//                                    topic: d["topic"] as! String,
//                                    q: d["question"] as! String,
//                                    opts: d["options"] as! [String],
//                                    resps: d["responses"] as! [Int],
//                                    corr: d["correct"] as! Int,
//                                    cat: d["category"] as! String,
//                                    diff: d["rating"] as! Int)
//                  result.append(ques)
//              }
//            } catch {
//              print("Error getting documents: \(error)")
//            }
//            return result
//    }
//    func getIDs(cat:String, rat: Int)async ->[(Int,Int)]{
//        //IMPLEMENT THIS FUNCTION
//        var result = [(Int,Int)]()
//        //return result
//        //INCORRECT IMPLEMENTATION:
//        var indices = Set<Int>()
//        for i in 0..<50{
//            let ind = Int.random(in:0...1600)
//            indices.insert(ind)
//        }
//        for i in indices{
//            result.append((i,Int.random(in:750...2000)))
//        }
//        return result
//    }
    
    func updateActivityLog() async {
        print("updateActivity log called")
        let entriesCount = CoreDataStack.shared.mSeen!.allSeen!.count
        print(entriesCount)
        //if entriesCount==0 || entriesCount%10 != 0{
        //     return
        //}
        print("updateActivity log passed size screen")
        let deviceID = await UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
        print("Device ID: \(deviceID)")
        let db = Firestore.firestore().collection("userLogs").document(deviceID)
        var qIDS = [Int]()
        var resps = [Int]()
        for i in 0..<10{
            let qAdd = CoreDataStack.shared.mSeen!.allSeen![entriesCount - 10 + i]
            qIDS.append(qAdd[0])
            resps.append(qAdd[1])
        }
        let data : [String : Any] = ["timestamp" : Int(NSDate().timeIntervalSince1970 - 1713426675),
                                     "ids"  : qIDS,
                                     "responses" : resps,
                                     "ratings" : CoreDataStack.shared.mSeen!.ratings!]
        let dataChunk : [String : Any] = [String(data["timestamp"] as! Int) : data]
        do {
            try await db.setData(dataChunk, merge: true)
        }
        catch{
            print("failed to upload log because of \(error)")
        }
        print("updateActivityLog finished =)")
    }
    
    //implement this!!
    func updateHardCodedVals(){
        
    }
    //implement this!!!
    func updateQuestionDatabase(){
        
    }
}
