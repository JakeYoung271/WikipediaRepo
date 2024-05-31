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
    let TIME_OFFSET = 1713426675.0
    static let pub = fbase()
    var liked = [Int]()
    var disliked = [Int]()
    private init(){
    }
    func addResponse(id: Int, likedQ: Bool){
        if likedQ {
            liked.append(id)
        }
        else {
            disliked.append(id)
        }
    }
    
    //return to this
    func updateActivityLog() async {
        print("updateActivity log called")
        let entriesCount = CoreDataStack.shared.mSeen!.allSeen!.count
        print(entriesCount)
        if entriesCount==0 || entriesCount%10 != 0{
             return
        }
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
        let data : [String : Any] = ["timestamp" : Int(NSDate().timeIntervalSince1970 - TIME_OFFSET),
                                     "ids"  : qIDS,
                                     "responses" : resps,
                                     "ratings" : CoreDataStack.shared.mSeen!.ratings!,
                                     "likedIDs" : liked,
                                     "dislikedIDs": disliked]
        let dataChunk : [String : Any] = [String(data["timestamp"] as! Int) : data]
        do {
            try await db.setData(dataChunk, merge: true)
        }
        catch{
            print("failed to upload log because of \(error)")
        }
        print("updateActivityLog finished =)")
        liked = []
        disliked = []
    }
    
    func getRatingsDoc() async {
        let db = Firestore.firestore()
        let docRef = db.collection("ratings").document("currRatings")
        do {
            let document = try await docRef.getDocument()
            if var data = document.data() {
                let time = Int(NSDate().timeIntervalSince1970 - TIME_OFFSET)
                data["time"] = time
                writeJSON(name: "currRatings", data: data)
            }
        } catch {
            print("failed to download ratings because of \(error)")
        }
        qRec.pub.updateQRec()
    }
    
    func getDumpDoc(name: String) async -> Bool {
        let db = Firestore.firestore()
        let docRef = db.collection("dumps").document(name)
        do {
            let document = try await docRef.getDocument()
            if let data = document.data() {
                writeJSON(name: name, data: data)
                return true
            }
        } catch {
            print("failed to download dump because of \(error)")
        }
        return false
    }
    
    //implement this function!
    func reportQuestion(id: Int, report: String){
        
    }
    
    //implement this!!!
    func updateQuestionDatabase(){
        
    }
}
