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
    private init(){
    }

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
