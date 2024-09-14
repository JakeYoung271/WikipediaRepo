//
//  DataManager.swift
//  TriviaWiki
//
//  Created by Jake Young on 5/30/24.
//

import Foundation

extension String: Error {}

func copyToDocuments(name filename: String) {
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let destinationURL = documentsURL.appendingPathComponent(filename)
    
    // Check if file already exists in the Documents directory
    if !fileManager.fileExists(atPath: destinationURL.path) {
        if let bundleURL = Bundle.main.url(forResource: filename, withExtension: nil) {
            do {
                try fileManager.copyItem(at: bundleURL, to: destinationURL)
                print("\(filename) copied to Documents folder.")
            } catch {
                print("Error copying \(filename): \(error)")
            }
        } else {
            print("\(filename) not found in the app bundle.")
        }
    } else {
        print("\(filename) already exists in Documents folder.")
    }
}

func readFromBundle(filename: String) -> [String: Any]? {
    if let bundleURL = Bundle.main.url(forResource: filename, withExtension: "json") {
        do {
            let data = try Data(contentsOf: bundleURL)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            }
        } catch {
            print("Error reading JSON from bundle: \(error)")
        }
    } else {
        print("File \(filename).json not found in bundle.")
    }
    return nil
}

func readFromDocuments(filename: String) -> [String: Any]? {
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsURL.appendingPathComponent(filename)
    
    if fileManager.fileExists(atPath: fileURL.path) {
        do {
            let data = try Data(contentsOf: fileURL)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            }
        } catch {
            print("Error reading JSON from documents: \(error)")
        }
    } else {
        print("File \(filename) not found in documents.")
    }
    return nil
}
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func writeJSON(name: String, data: [String: Any]) {
    let fileURL = getDocumentsDirectory().appendingPathComponent("\(name).json")
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        try jsonData.write(to: fileURL)
        print("Successfully wrote to \(fileURL)")
    } catch {
        print("Failed to write JSON data: \(error.localizedDescription)")
    }
}

func generalCat(cat:String) ->Int{
    let Sci = ["Medicine", "Mathematicians", "Economics", "Chemistry", "Mathematics", "Physics"]
    let Hum = ["Political_Science", "Philosophy", "Ethics_&_Morality", "Activists", "Philosophers"]
    let Art = ["Singers", "Famous_People", "Actors", "Playwrights", "Politicians", "Artists"]
    if Sci.contains(cat){return 0}
    if Hum.contains(cat){return 1}
    if Art.contains(cat){return 2}
    return -1
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

class DataManager {
    static let shared = DataManager()
    let TIME_OFFSET = 1713426675.0
    var questionsList : [[String: Any]]
    var ratings : [Int]
    var numQuestions: Int
    var responseNums : [[String:[Int]]]
    var seenIDs : [Int]
    var seenQuestions : [Int: Any]
    var seenSet : Set<Int>
    var modifiedIDs : Set<Int>
    var userRatings : [Int]
    var userQsCompleted : [Int]
    var toUpload : [[String: Any]]
    init(){
        print("Initializing Data Manager")
        modifiedIDs = Set<Int>()
        seenSet = Set<Int>()
        seenQuestions = [Int: Any]()
        questionsList = [[String: Any]]()
        responseNums = [[String:[Int]]]()
        
        //setup the user history
        copyToDocuments(name: "seen.json")
        let seenData = readFromDocuments(filename: "seen.json")!
        seenIDs = seenData["seenIDs"] as! [Int]
        for i in seenIDs {
            seenSet.insert(i)
        }
        let seenArray = seenData["seenArray"] as! [[String:Any]]
        for i in seenArray {
            let tempID = i["id"] as! Int
            seenQuestions[tempID] = i
        }
        userRatings = seenData["userRatings"] as! [Int]
        userQsCompleted = seenData["questionsCompleted"] as! [Int]
        toUpload = seenData["toUpload"] as! [[String: Any]]
        
        numQuestions = 1603
        copyToDocuments(name: "currRatings.json")
        let dumpDict = readFromBundle(filename: "dump0")
       questionsList = dumpDict!["qArray"] as! [[String:Any]]
        let ratingsDict = readFromDocuments(filename: "currRatings.json")
        ratings = ratingsDict!["allRatings"] as! [Int]
        responseNums = ratingsDict!["allResponses"] as! [[String:[Int]]]
        
        Task {
            if (await fbase.pub.uploadUserHistory(History: toUpload)) {
                clearToUpload()
            }
        }
        
    }
    
    func clearToUpload(){
        toUpload.removeAll()
    }
    
    func saveSession(){
        var seenData = readFromDocuments(filename: "seen.json")!
        seenData["userRatings"] = userRatings
        seenData["questionsCompleted"] = userQsCompleted
        seenData["seenIDs"] = seenIDs
        var seenArray = [[String: Any]]()
        for i in modifiedIDs {
            let serializedQ = QuestionFactory.shared.getQuestion(id: i).serializeData()
            seenQuestions[i] = serializedQ
            toUpload.append(serializedQ)
        }
        seenData["toUpload"] = toUpload
        for i in seenQuestions.values {
            seenArray.append(i as! [String : Any])
        }
        seenData["seenArray"] = seenArray
        writeJSON(name: "seen", data: seenData)
    }
    
    func seeQuestion(id:Int){
        if !seenSet.contains(id){
            seenIDs.append(id)
            seenSet.insert(id)
        }
        modifiedIDs.insert(id)
    }
    
    func applyRatingChange(q:Question){
        let id = q.id
        let cat = getQuestion_cat(id: id)
        userQsCompleted[cat] += 1
        let result = q.completedCorrectly() ? 1 : 0
        let userRating = userRatings[cat]
        let questionRating = getQuestion_rating(id: id)
        let KFactor = max(16, Int(800.0  / Double(userQsCompleted[cat])))
        let delta = getRatingChange(playerRating: userRating, questionRating: questionRating, performance: result, K: KFactor)
        print("User ratings: \(userRatings)")
        print("applying rating change to question with id \(id), result: \(result), uRating \(userRating), qRating \(questionRating), K: \(KFactor), resulting in a delta val of \(delta)")
        userRatings[cat] += delta
        print("the user's ratings are now \(userRatings)")
    }
    
    func getQuestion_question(id:Int) -> String{
        if (id < numQuestions && id>=0){
            let questionDict = questionsList[id]
            return questionDict["question"] as! String
        } else {
            print("Failed to get question in question with id \(id)")
            return "id out of range"
        }
    }
    func getQuestion_rating(id:Int) -> Int{
        if (id < numQuestions && id>=0){
            return ratings[id]
        } else {
            print("Failed to get ratings in question with id \(id)")
            return -1
        }
    }
    func getQuestion_options(id:Int) -> [String]{
        if (id < numQuestions && id>=0){
            let questionDict = questionsList[id]
            return questionDict["options"] as! [String]
        } else {
            print("Failed to get options in question with id \(id)")
            return ["id out of range", "id out of range", "id out of range", "id out of range"]
        }
    }
    func getQuestion_link(id:Int) -> String{
        if (id < numQuestions && id>=0){
            let questionDict = questionsList[id]
            return "https://en.wikipedia.org/wiki/\((questionDict["topic"] as! String).replacingOccurrences(of: " ", with: "_"))"
        } else {
            print("Failed to get link in question with id \(id)")
            return "id out of range"
        }
    }
    func getQuestion_topic(id:Int) -> String{
        if (id < numQuestions && id>=0){
            let questionDict = questionsList[id]
            return questionDict["topic"] as! String
        } else {
            print("Failed to get topic in question with id \(id)")
            return "id out of range"
        }
    }
    func getQuestion_correctIndex(id:Int) -> Int{
        if (id < numQuestions && id>=0){
            let questionDict = questionsList[id]
            return questionDict["correct"] as! Int
        } else {
            print("Failed to get correct index in question with id \(id)")
            return -1
        }
        
    }
    func getQuestion_quote(id:Int) -> String{
        if (id < numQuestions && id>=0){
            let questionDict = questionsList[id]
            return questionDict["quote"] as! String
        } else {
            print("Failed to get quote in question with id \(id)")
            return "id out of range"
        }
    }
    func getQuestion_responseNums(id:Int) -> [Int]{
        if (id < numQuestions && id>=0){
            return responseNums[id]["\(id)"]!
        } else {
            print("Failed to get response nums in question with id \(id)")
            return [-1,-1,-1,-1]
        }
    }
    func getQuestion_timesPlayed(id:Int)->Int{
        if (id < numQuestions && id>=0){
            let vals =  responseNums[id]["\(id)"]!
            var total = 0
            for i in vals {
                total += i
            }
            return total
        } else {
            print("Failed to get timesPlayed in question with id \(id)")
            return -1
        }
    }
    func getQuestion_cat(id:Int)->Int{
        if (id<numQuestions && id>=0){
            let category = questionsList[id]["category"] as! String
            return generalCat(cat: category)
        } else {
            print("id out of bound \(id) when trying to get question cat")
            return -1
        }
    }
    func getQuestion_seen(id:Int)->Bool{
        return seenSet.contains(id)
    }
    func getQuestion_complete(id: Int)->Bool{
        if seenSet.contains(id){
            return (seenQuestions[id] as! [String: Any])["complete"] as! Bool
        }
        return false
    }
    func getQuestion_revealedHint(id: Int)->Bool{
        if seenSet.contains(id){
            return (seenQuestions[id] as! [String: Any])["revealedHint"] as! Bool
        }
        return false
    }
    func getQuestion_selectedIndex(id: Int)->Int?{
        if seenSet.contains(id) {
            return (seenQuestions[id] as! [String:Any])["selectedIndex"] as? Int
        }
        return nil
    }
    func getQuestion_liked(id: Int)->Bool?{
        if seenSet.contains(id) {
            return (seenQuestions[id] as! [String:Any])["liked"] as? Bool
        }
        return nil
    }
    func getQuestion_report(id: Int)->String?{
        if seenSet.contains(id) {
            return (seenQuestions[id] as! [String:Any])["report"] as? String
        }
        return nil
    }
    func getUserRating(cat:Int)->Int{
        return userRatings[cat]
    }
}
