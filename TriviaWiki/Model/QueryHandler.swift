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
    func updateActivityLog(forced: Bool) async {
        print("RUNNING updateActivityLog, with forced = \(forced)")
        let entriesCount = HistoryManager.shared.toUpload.count
        if entriesCount < 10 && !forced {
            print("EXITING updateActivityLog, no action taken")
             return
        }
        let deviceID = await UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
        let db = Firestore.firestore().collection("userLogs").document(deviceID)
        let data : [String : Any] = ["timestamp" : Int(NSDate().timeIntervalSince1970 - TIME_OFFSET),
                                     "questions": HistoryManager.shared.toUpload,
                                     "ratings" : HistoryManager.shared.ratings]
        let dataChunk : [String : Any] = [String(data["timestamp"] as! Int) : data]
        do {
            try await db.setData(dataChunk, merge: true)
            print("UPLOADED \(HistoryManager.shared.toUpload)")
            HistoryManager.shared.toUpload = [:]
            HistoryManager.shared.save()
        }
        catch{
            print("ERROR: failed to upload log because of \(error)")
            HistoryManager.shared.save()
        }
    }
    
    func getRatingsDoc() async {
        print("RUNNING getRatingsDoc")
        
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
        print("RUNNING fbase::getDumpDoc with parameter \(name)")
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
}
